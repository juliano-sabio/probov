import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../domain/pricing.dart';
import '../../domain/report_data.dart';
import '../../providers.dart';
import 'pdf_relatorio.dart';

class RelatorioScreen extends ConsumerWidget {
  final int loteId;
  const RelatorioScreen({super.key, required this.loteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatorio = ref.watch(relatorioProvider(loteId));
    final pronto = relatorio.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Relatorio')),
      floatingActionButton: pronto == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => compartilharPdf(pronto),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Exportar PDF'),
            ),
      body: relatorio.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (r) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(r.loteNome, style: Theme.of(context).textTheme.headlineSmall),
            Text(formatData(r.data)),
            if (r.contraparte != null) Text(r.contraparte!),
            const SizedBox(height: 16),
            _Criterio(cfg: r.cfg),
            const Divider(height: 32),
            _Resumo(r: r),
            const Divider(height: 32),
            Text('Animais', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...r.linhas.map((l) => _Linha(linha: l, cfg: r.cfg)),
          ],
        ),
      ),
    );
  }
}

class _Criterio extends StatelessWidget {
  final PrecoConfig cfg;
  const _Criterio({required this.cfg});

  @override
  Widget build(BuildContext context) {
    final base = switch (cfg.criterio) {
      CriterioBase.arroba =>
        '${formatBrl(cfg.precoBaseCentavos)} por @  -  rendimento ${formatPercentBp(cfg.rendimentoBp)}',
      CriterioBase.kg => '${formatBrl(cfg.precoBaseCentavos)} por kg',
      CriterioBase.cabeca => '${formatBrl(cfg.precoBaseCentavos)} por cabeca',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Criterio', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(base),
        if (cfg.regras.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('${cfg.regras.length} regra(s) de excecao aplicadas'),
          ),
      ],
    );
  }
}

class _Resumo extends StatelessWidget {
  final ReportData r;
  const _Resumo({required this.r});

  @override
  Widget build(BuildContext context) {
    final itens = <(String, String)>[
      ('Cabecas', '${r.cabecas}'),
      ('Peso total', formatKg(r.pesoTotalG)),
      ('Peso medio', formatKg(r.pesoMedioG)),
      if (r.cfg.criterio == CriterioBase.arroba)
        ('Arrobas totais', formatArrobas(r.arrobasTotalCentesimos)),
      ('Valor medio por cabeca', formatBrl(r.valorMedioCentavos)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...itens.map((i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(i.$1), Text(i.$2)],
              ),
            )),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('TOTAL', style: Theme.of(context).textTheme.titleLarge),
            Text(
              formatBrl(r.valorTotalCentavos),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ],
    );
  }
}

class _Linha extends StatelessWidget {
  final LinhaRelatorio linha;
  final PrecoConfig cfg;
  const _Linha({required this.linha, required this.cfg});

  @override
  Widget build(BuildContext context) {
    final meio = [
      formatKg(linha.pesoG),
      if (cfg.criterio == CriterioBase.arroba)
        formatArrobas(linha.arrobasCentesimos),
      if (linha.brinco != null) 'brinco ${linha.brinco}',
    ].join('  -  ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text('${linha.sequencia}')),
          Expanded(child: Text(meio)),
          Text(formatBrl(linha.valorCentavos)),
        ],
      ),
    );
  }
}
