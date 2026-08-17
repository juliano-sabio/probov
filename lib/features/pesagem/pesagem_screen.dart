import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/parse.dart';
import '../../domain/pricing.dart';
import '../../providers.dart';
import '../animais/animais_screen.dart';
import '../lotes/lote_form_screen.dart';
import '../relatorio/relatorio_screen.dart';
import 'keypad.dart';

/// Peso acima disto gera aviso, mas é aceito: existe touro grande, e um app
/// que impede o usuário de registrar a realidade é pior que um permissivo.
const int pesoSuspeitoG = 2000000;

class PesagemScreen extends ConsumerStatefulWidget {
  final int loteId;
  const PesagemScreen({super.key, required this.loteId});

  @override
  ConsumerState<PesagemScreen> createState() => _PesagemScreenState();
}

class _PesagemScreenState extends ConsumerState<PesagemScreen> {
  String _digitos = '';
  final _brinco = TextEditingController();
  bool _detalhes = false;
  int? _ultimoAnimalId;

  @override
  void dispose() {
    _brinco.dispose();
    super.dispose();
  }

  int? get _pesoG {
    final p = parsePesoG(_digitos);
    return (p == null || p <= 0) ? null : p;
  }

  @override
  Widget build(BuildContext context) {
    final relatorio = ref.watch(relatorioProvider(widget.loteId));
    final lote = ref.watch(loteProvider(widget.loteId)).valueOrNull;
    final r = relatorio.valueOrNull;

    final pesoG = _pesoG;
    final previa = (r != null && pesoG != null)
        ? precificar(r.cfg, pesoG: pesoG, raca: lote?.racaPadrao)
        : null;
    final arrobas =
        (r != null && pesoG != null && r.cfg.criterio == CriterioBase.arroba)
            ? arrobasCentesimos(
                pesoG: pesoG,
                rendimentoBp:
                    resolverPreco(r.cfg, pesoG: pesoG, raca: lote?.racaPadrao)
                        .rendimentoBp)
            : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(lote?.nome ?? 'Pesagem'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Editar lote e preços',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoteFormScreen(loteId: widget.loteId),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Animais',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AnimaisScreen(loteId: widget.loteId),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.description_outlined),
            tooltip: 'Relatório',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RelatorioScreen(loteId: widget.loteId),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _Cabecalho(
                cabecas: r?.cabecas ?? 0,
                totalCentavos: r?.valorTotalCentavos ?? 0,
              ),
              const Divider(),
              // O teclado tem altura fixa e prioridade: numa tela baixa, ou com
              // fonte de sistema ampliada, é o display que cede. FittedBox faz
              // ele encolher em vez de estourar o layout.
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      // min é obrigatório aqui: dentro do FittedBox a altura
                      // é ilimitada, e `max` pediria altura infinita.
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _digitos.isEmpty ? '0' : _digitos,
                          style: TextStyle(
                            fontSize: 68,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -2,
                            height: 1,
                            // Sem largura fixa de dígito o número inteiro salta
                            // para os lados a cada tecla digitada.
                            fontFeatures: const [FontFeature.tabularFigures()],
                            color: _digitos.isEmpty
                                ? Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withValues(alpha: 0.25)
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'kg',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                letterSpacing: 1.5,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          previa == null
                              ? '-'
                              : arrobas == null
                                  ? formatBrl(previa)
                                  : '${formatArrobas(arrobas)}   ${formatBrl(previa)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_detalhes)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: _brinco,
                    decoration: const InputDecoration(
                      labelText: 'Brinco (opcional)',
                      isDense: true,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => setState(() => _detalhes = !_detalhes),
                  icon: Icon(_detalhes ? Icons.expand_less : Icons.expand_more),
                  label: const Text('Detalhes'),
                ),
              ),
              Keypad(
                onTecla: (t) => setState(() {
                  if (t == ',' && _digitos.contains(',')) return;
                  _digitos += t;
                }),
                onApagar: () => setState(() {
                  if (_digitos.isNotEmpty) {
                    _digitos = _digitos.substring(0, _digitos.length - 1);
                  }
                }),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (_ultimoAnimalId != null)
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: _desfazerUltimo,
                          icon: const Icon(Icons.undo),
                          label: const Text('Desfazer'),
                        ),
                      ),
                    ),
                  if (_ultimoAnimalId != null) const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: pesoG == null ? null : _salvar,
                        child: const Text('SALVAR',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _salvar() async {
    final pesoG = _pesoG;
    if (pesoG == null) return;

    if (pesoG > pesoSuspeitoG) {
      final segue = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Peso muito alto'),
          content: Text(
              '${formatKg(pesoG)} e um peso incomum. Registrar assim mesmo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Corrigir'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Registrar'),
            ),
          ],
        ),
      );
      if (!(segue ?? false)) return;
    }

    final lote = ref.read(loteProvider(widget.loteId)).valueOrNull;
    final brinco = _brinco.text.trim();
    final id = await ref.read(animalRepoProvider).inserir(
          loteId: widget.loteId,
          pesoG: pesoG,
          brinco: brinco.isEmpty ? null : brinco,
          raca: lote?.racaPadrao,
        );

    setState(() {
      _digitos = '';
      _brinco.clear();
      _ultimoAnimalId = id;
    });
  }

  Future<void> _desfazerUltimo() async {
    final id = _ultimoAnimalId;
    if (id == null) return;
    await ref.read(animalRepoProvider).excluir(id);
    setState(() => _ultimoAnimalId = null);
  }
}

class _Cabecalho extends StatelessWidget {
  final int cabecas;
  final int totalCentavos;

  const _Cabecalho({required this.cabecas, required this.totalCentavos});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cabeças'),
            Text('$cabecas', style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        const Spacer(),
        // Flexible + FittedBox porque o total cresce com o lote: em telas de
        // 360dp, "R$ 1.234.567,89" nao cabe ao lado do contador e estouraria.
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total do lote'),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formatBrl(totalCentavos),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
