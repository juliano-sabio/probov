# Probov — Pesagem e Precificação de Bovinos

**Data:** 2026-07-31
**Status:** aprovado para implementação
**Stack:** Flutter 3.38.6 / Dart 3.10.7, Drift (SQLite), Riverpod, pdf + printing

## Objetivo

Aplicativo móvel offline para registrar o peso de bovinos individualmente durante
compra, venda ou manejo, calcular o valor de cada animal e o total do lote em tempo
real, e gerar um relatório exportável em PDF. Qualquer dado de um lote já pesado pode
ser editado a qualquer momento, e o relatório reflete a mudança sem ação do usuário.

## Requisitos

1. Critério de precificação por lote: por arroba, por quilograma, por cabeça, com
   preço podendo variar por faixa de peso e por raça.
2. Registro individual de animais com peso digitado manualmente.
3. Cálculo automático do valor por animal e do total do lote em tempo real.
4. Relatório detalhado do lote.
5. Exportação do relatório em PDF, compartilhável.
6. Edição de qualquer dado de um lote existente — pesos, animais (adicionar e
   remover), critério e preços — com atualização automática do relatório.
7. Funcionamento integralmente offline.

## Fora de escopo

Decisões deliberadas, não omissões:

- **Quebra/desconto de peso por transporte.** Comum no mercado e provavelmente pedido
  no futuro. Custa um campo em `Lote` e uma linha em `pricing.dart` quando for a hora.
- **Sync em nuvem, contas de usuário, multi-dispositivo.** O cliente pediu offline.
- **Integração com balança (Bluetooth/serial).** O requisito é peso digitado.
- **Motor de regras genérico** (condições livres sobre qualquer campo). A tabela de
  regras por faixa de peso e raça cobre os cinco critérios pedidos com um só modelo.

## Domínio

### Modelo de dados

Três tabelas. Nenhuma coluna de valor calculado em nenhuma delas.

```
Lote        id, nome, data, contraparte?, obs?
            criterioBase: ARROBA | KG | CABECA
            precoBaseCentavos: int
            rendimentoBp: int              -- basis points, 5200 = 52,00%
            racaPadrao?                    -- pré-preenche a raça na pesagem
            criadoEm, atualizadoEm

RegraPreco  id, loteId, ordem
            pesoMinG?, pesoMaxG?, raca?    -- condições; nulo = não filtra
            precoCentavos: int
            rendimentoBp?                  -- nulo herda do lote

Animal      id, loteId, sequencia, pesoG: int
            brinco?, raca?, sexo?, obs?
            criadoEm
```

### Unidades

- **Dinheiro em centavos (`int`).** `double` acumula erro de ponto flutuante e, num
  lote de 200 animais, o total não fecha com a calculadora do cliente.
- **Peso em gramas (`int`).** Balança de bovino dá uma casa decimal (480,5 kg).
- **Percentual em basis points (`int`).** Mesmo motivo do dinheiro.

A formatação para exibição (R$, kg, @) vive em `core/format.dart` e nunca no domínio.

### Regra de cálculo

Função pura em `domain/pricing.dart`, sem dependência de Flutter ou Drift:

```dart
int precificar(Animal a, Lote l, List<RegraPreco> regras) → centavos
```

1. **Resolução da regra.** A primeira regra, em ordem crescente de `ordem`, cujas
   condições não nulas *todas* casam:
   - `pesoMinG` casa se `a.pesoG >= pesoMinG`
   - `pesoMaxG` casa se `a.pesoG <= pesoMaxG`
   - `raca` casa se igual à raça do animal (comparação exata, sem normalização)

   `Lote.racaPadrao` apenas pré-preenche o campo na tela de pesagem; o valor é copiado
   para a linha do animal ao salvar. A precificação nunca faz fallback do animal para o
   lote — se a raça do animal é nula, uma regra com raça simplesmente não casa. Isso
   mantém a função pura sem conhecimento de defaults de UI.
   Se nenhuma regra casa, usa `precoBaseCentavos` e `rendimentoBp` do lote.
   Se a regra casa mas tem `rendimentoBp` nulo, herda o do lote.
2. **`ARROBA`:** `peso × rendimento ÷ 15 × preço`
3. **`KG`:** `peso × preço`
4. **`CABECA`:** `preço` (peso é ignorado no valor, mas continua registrado e somado
   no peso total do relatório)

Arredondamento para o centavo mais próximo, uma única vez, no fim do cálculo de cada
animal. O total é a soma dos valores já arredondados — é assim que uma nota fiscal
fecha, e é o que o cliente vai conferir linha por linha.

**Convenção de arroba.** Existem duas no mercado: arroba sobre carcaça (rendimento de
~50% a 54%) e arroba sobre peso vivo. Como o rendimento é um campo editável,
`rendimentoBp = 10000` (100%) já expressa a arroba sobre peso vivo. Um campo, as duas
convenções, nenhum código extra.

### O total nunca é gravado

O valor por animal e o total do lote são sempre derivados na leitura. O banco agrega
apenas dados brutos (contagem de animais e soma de peso); o dinheiro é calculado em
Dart, aplicando `precificar` a cada animal e somando os centavos já arredondados. A
resolução de regra em SQL seria ilegível e um `SUM` no banco somaria valores não
arredondados, divergindo da tabela do relatório linha por linha.

Um provider Riverpod observa o stream de animais, o lote e as regras, e recalcula. É
isto que faz o requisito 6 sair de graça: editar peso, preço, rendimento, raça ou uma
regra invalida o provider, e tela, relatório e PDF se atualizam juntos. Não existe
caminho no código em que possam divergir, porque não existe cópia do número.

Na lista de lotes, o total de cada lote é derivado do mesmo jeito. Em escala de celular
(dezenas de lotes, centenas de animais) isso é irrelevante em custo. Se algum dia doer,
a correção é um total em cache invalidado pelo DAO — e não vale a complexidade agora.

## Arquitetura

```
lib/
  core/        money.dart, units.dart, format.dart
  domain/      pricing.dart, report_data.dart, enums.dart
  data/        database.dart (tabelas + migrações), daos/
  features/    lotes/  pesagem/  regras/  relatorio/  pdf/
```

`domain/` é Dart puro: não importa Flutter nem Drift. O cálculo — a única parte onde um
erro custa dinheiro do cliente — é testável sem emulador.

Riverpod para estado derivado, Drift para persistência tipada com migrações
versionadas. O schema vai mudar (a tabela de regras é a primeira candidata), e migração
versionada é a diferença entre evoluir o app e pedir para o usuário reinstalar.

Navegação com `Navigator` e `MaterialPageRoute` de construtores tipados — não rotas
nomeadas, porque quase toda tela recebe um `loteId` e um construtor tipado é conferido
pelo compilador, enquanto `arguments` de rota nomeada só falha em runtime. Cinco telas
de hierarquia rasa não pagam uma dependência de roteamento.

## Telas

1. **Lista de lotes** (home) — nome, data, cabeças, total de cada lote. Criar, abrir,
   excluir com undo.
2. **Configuração do lote** — critério base, preço, rendimento, e a lista reordenável
   de regras de preço.
3. **Pesagem** — teclado numérico grande, contador `n/total`, valor do animal e total do
   lote ao vivo, desfazer do último registro. Brinco, raça e sexo ficam recolhidos e a
   raça herda o padrão do lote. Esta é a tela do sol, da luva e do boi na balança:
   cada campo obrigatório extra é atrito multiplicado por 200 cabeças.
4. **Lista de animais** — editar peso e brinco, excluir com undo.
5. **Relatório** — resumo (cabeças, peso total, peso médio, arrobas totais, valor
   total, valor médio por cabeça), tabela por animal, botão de exportar PDF.

## Relatório e PDF

Pacotes `pdf` (montagem declarativa) e `printing` (compartilhar/imprimir), ambos
offline. `MultiPage` para a tabela paginar sozinha em lotes grandes.
`Printing.sharePdf` abre o share sheet nativo, cobrindo WhatsApp, e-mail e "salvar em
arquivo" com uma chamada.

Fonte: a Helvetica embutida do PDF, sem asset. Ela usa WinAnsiEncoding, que contém
todos os acentos do português — o problema clássico de acentuação no PDF aparece fora do
Latin-1. A restrição que isso impõe é concreta e vale registrar: nada de setas, `→`,
travessão longo ou símbolos tipográficos no layout. Se um dia entrar um glifo fora do
Latin-1, aí sim entra uma TTF como asset.

O layout consome um `ReportData` puro. Os números são testados sem gerar PDF nenhum; o
layout apenas desenha. Não haverá golden test de PDF — é frágil e de baixo valor aqui.

Conteúdo do PDF: cabeçalho com lote, data, contraparte e critério aplicado (incluindo
preço e rendimento); tabela com sequência, brinco, peso, arrobas ou kg, preço aplicado
e valor; rodapé com os totais do resumo e numeração de páginas.

## Tratamento de erros

- Peso menor ou igual a zero é bloqueado.
- Peso acima de 2000 kg gera aviso mas é aceito. Existe touro grande, e um app que
  impede o usuário de registrar a realidade é pior que um app permissivo.
- Regra com `pesoMinG > pesoMaxG` é bloqueada no editor.
- Preço zero é aceito (manejo sem precificação é um uso legítimo do app).
- Lote sem animais gera relatório vazio, com totais zerados, sem erro.
- Excluir animal tem undo via SnackBar. Excluir lote tem diálogo de confirmação, não
  undo: a exclusão leva animais e regras em cascata, e oferecer "desfazer" para algo que
  já foi apagado em cascata é uma promessa que a UI não pode cumprir.

## Testes

- **Unitário puro em `pricing.dart`** — os três critérios, a resolução de regras
  (nenhuma casa, primeira casa, herança de rendimento), arredondamento, e a
  equivalência `rendimento = 100%` ↔ arroba sobre peso vivo. Valores conferidos à mão.
- **Drift em memória** (`NativeDatabase.memory()`) para DAOs e migração de schema.
- **Widget test na pesagem** — digitar peso, salvar, total atualiza.
- **`ReportData`** — resumo de um lote conhecido produz os números esperados.

## Offline

Não há nenhuma chamada de rede no app. O manifest Android não declara
`INTERNET`, o que torna a garantia verificável e não apenas afirmada.
