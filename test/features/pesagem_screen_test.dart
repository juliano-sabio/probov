import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:probov/data/repositories.dart';
import 'package:probov/domain/pricing.dart';
import 'package:probov/domain/report_data.dart';
import 'package:probov/features/pesagem/pesagem_screen.dart';
import 'package:probov/providers.dart';

import '../helpers/db.dart';

/// Este teste NÃO usa banco de verdade, de propósito.
///
/// `testWidgets` roda em fake async: a emissão de um stream do drift nunca
/// chega e o cancelamento dele agenda um timer que fica pendente, o que faz o
/// framework reprovar o teste. A propagação real (editar peso -> total muda)
/// está coberta em `test/providers_test.dart`, que roda com async de verdade.
/// Aqui o objeto de teste é a tela: prévia, estado do botão e a chamada de
/// gravação.
void main() {
  const loteId = 1;

  final lote = LoteRow(
    id: loteId,
    nome: 'Boiada Janeiro',
    data: DateTime(2026, 7, 31),
    criterioBase: CriterioBase.arroba,
    precoBaseCentavos: 32000,
    rendimentoBp: 5200,
    criadoEm: DateTime(2026, 7, 31),
    atualizadoEm: DateTime(2026, 7, 31),
  );

  const cfg = PrecoConfig(
    criterio: CriterioBase.arroba,
    precoBaseCentavos: 32000,
    rendimentoBp: 5200,
    regras: [],
  );

  ReportData relatorioCom(List<int> pesos) => montarRelatorio(
        loteNome: lote.nome,
        data: lote.data,
        cfg: cfg,
        animais: [
          for (var i = 0; i < pesos.length; i++)
            AnimalInput(id: i + 1, sequencia: i + 1, pesoG: pesos[i]),
        ],
      );

  Future<void> abrir(
    WidgetTester tester, {
    required AnimalRepository repo,
    List<int> pesos = const [],
  }) async {
    // O default do widget test e 800x600 (paisagem), que nao existe no uso
    // real: esta e uma tela de celular em retrato, na balanca.
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        animalRepoProvider.overrideWithValue(repo),
        loteProvider(loteId).overrideWith((ref) => Stream.value(lote)),
        relatorioProvider(loteId)
            .overrideWithValue(AsyncData(relatorioCom(pesos))),
      ],
      child: const MaterialApp(home: PesagemScreen(loteId: loteId)),
    ));
    await tester.pumpAndSettle();
  }

  Future<void> digitar(WidgetTester tester, String digitos) async {
    for (final d in digitos.split('')) {
      await tester.tap(find.widgetWithText(OutlinedButton, d));
    }
    await tester.pump();
  }

  testWidgets('a previa mostra arrobas e valor antes de salvar',
      (tester) async {
    final repo = _RepoEspiao();
    await abrir(tester, repo: repo);

    expect(find.text(r'R$ 0,00'), findsOneWidget, reason: 'total do lote vazio');

    await digitar(tester, '480');

    // 480 kg a 52% = 249,6 kg de carcaca; /15 = 16,64@; * R$ 320 = R$ 5.324,80
    expect(find.text(r'16,64 @   R$ 5.324,80'), findsOneWidget);
  });

  testWidgets('a previa aceita peso com casa decimal', (tester) async {
    final repo = _RepoEspiao();
    await abrir(tester, repo: repo);

    await digitar(tester, '480,5');

    expect(find.textContaining('16,66 @'), findsOneWidget);
  });

  testWidgets('SALVAR fica desabilitado sem peso', (tester) async {
    final repo = _RepoEspiao();
    await abrir(tester, repo: repo);

    final botao = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'SALVAR'),
    );
    expect(botao.onPressed, isNull);
  });

  testWidgets('SALVAR grava o peso digitado e limpa o display',
      (tester) async {
    final repo = _RepoEspiao();
    await abrir(tester, repo: repo);

    await digitar(tester, '480');
    await tester.tap(find.text('SALVAR'));
    await tester.pumpAndSettle();

    expect(repo.inseridos, [480000], reason: 'peso em gramas');
    expect(find.text('0'), findsWidgets, reason: 'display volta a zero');
  });

  testWidgets('desfazer aparece so depois de salvar e exclui o ultimo',
      (tester) async {
    final repo = _RepoEspiao();
    await abrir(tester, repo: repo);

    expect(find.text('Desfazer'), findsNothing);

    await digitar(tester, '480');
    await tester.tap(find.text('SALVAR'));
    await tester.pumpAndSettle();

    expect(find.text('Desfazer'), findsOneWidget);

    await tester.tap(find.text('Desfazer'));
    await tester.pumpAndSettle();

    expect(repo.excluidos, [1]);
    expect(find.text('Desfazer'), findsNothing);
  });

  testWidgets('o cabecalho mostra o total do relatorio', (tester) async {
    final repo = _RepoEspiao();
    await abrir(tester, repo: repo, pesos: [480000, 520000]);

    // 532480 + 576853 = 1109333
    expect(find.text(r'R$ 11.093,33'), findsOneWidget);
    expect(find.text('2'), findsWidgets, reason: 'contador de cabecas');
  });
}

/// Registra as chamadas de gravação em vez de tocar o banco.
///
/// Estende [AnimalRepository] e nunca usa o campo `db` — os métodos que a tela
/// chama são todos sobrescritos.
class _RepoEspiao extends AnimalRepository {
  _RepoEspiao() : super(_dbNaoUsado);

  final List<int> inseridos = [];
  final List<int> excluidos = [];

  @override
  Future<int> inserir({
    required int loteId,
    required int pesoG,
    String? brinco,
    String? raca,
    String? sexo,
    String? obs,
  }) async {
    inseridos.add(pesoG);
    return inseridos.length;
  }

  @override
  Future<void> excluir(int id) async => excluidos.add(id);
}

/// O construtor de [AnimalRepository] exige um banco. Este é em memória e
/// nunca chega a ser aberto: o drift abre a conexão de forma preguiçosa, na
/// primeira consulta, e o espião sobrescreve tudo que a tela chama.
final _dbNaoUsado = dbDeTeste();
