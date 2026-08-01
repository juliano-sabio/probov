import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/format.dart';
import '../../domain/pricing.dart';
import '../../domain/report_data.dart';

/// Monta o PDF do relatório.
///
/// Usa a Helvetica embutida do PDF, sem asset de fonte: ela usa WinAnsi, que
/// cobre toda a acentuação do português. A restrição que isso impõe é real —
/// nada de setas, travessão longo ou símbolos tipográficos neste layout, só
/// Latin-1. Por isso os separadores abaixo são hifens.
Future<Uint8List> gerarPdfRelatorio(ReportData r) async {
  final doc = pw.Document(title: 'Relatorio ${r.loteNome}');
  final mostrarArrobas = r.cfg.criterio == CriterioBase.arroba;

  final cabecalhoTabela = <String>[
    'N',
    'Brinco',
    'Peso',
    if (mostrarArrobas) 'Arrobas',
    'Preco',
    'Valor',
  ];

  final dados = r.linhas
      .map((l) => <String>[
            '${l.sequencia}',
            l.brinco ?? '-',
            formatKg(l.pesoG),
            if (mostrarArrobas) formatArrobas(l.arrobasCentesimos),
            formatBrl(l.precoAplicadoCentavos),
            formatBrl(l.valorCentavos),
          ])
      .toList();

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      footer: (ctx) => pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Text(
          'Pagina ${ctx.pageNumber} de ${ctx.pagesCount}',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
      ),
      build: (ctx) => [
        _cabecalho(r),
        pw.SizedBox(height: 16),
        _criterio(r),
        pw.SizedBox(height: 16),
        if (dados.isEmpty)
          pw.Text('Nenhum animal registrado neste lote.')
        else
          pw.TableHelper.fromTextArray(
            headers: cabecalhoTabela,
            data: dados,
            headerStyle: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: const pw.TextStyle(fontSize: 10),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
              4: pw.Alignment.centerRight,
              5: pw.Alignment.centerRight,
            },
          ),
        pw.SizedBox(height: 16),
        _resumo(r),
      ],
    ),
  );

  return doc.save();
}

pw.Widget _cabecalho(ReportData r) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Probov - Relatorio de pesagem',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
        pw.SizedBox(height: 4),
        pw.Text(r.loteNome,
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
        pw.Text('Data: ${formatData(r.data)}'),
        if (r.contraparte != null) pw.Text('Contraparte: ${r.contraparte}'),
      ],
    );

pw.Widget _criterio(ReportData r) {
  final base = switch (r.cfg.criterio) {
    CriterioBase.arroba =>
      '${formatBrl(r.cfg.precoBaseCentavos)} por arroba, rendimento de carcaca ${formatPercentBp(r.cfg.rendimentoBp)}',
    CriterioBase.kg => '${formatBrl(r.cfg.precoBaseCentavos)} por quilograma',
    CriterioBase.cabeca => '${formatBrl(r.cfg.precoBaseCentavos)} por cabeca',
  };
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text('Criterio de precificacao',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text(base),
      if (r.cfg.regras.isNotEmpty)
        pw.Text(
          '${r.cfg.regras.length} regra(s) de excecao por faixa de peso ou raca. '
          'A coluna Preco mostra o valor aplicado a cada animal.',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
    ],
  );
}

pw.Widget _resumo(ReportData r) {
  pw.Widget linha(String rotulo, String valor, {bool destaque = false}) {
    final estilo = destaque
        ? pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)
        : const pw.TextStyle(fontSize: 11);
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(rotulo, style: estilo),
          pw.Text(valor, style: estilo),
        ],
      ),
    );
  }

  return pw.Container(
    padding: const pw.EdgeInsets.all(10),
    decoration:
        pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey600)),
    child: pw.Column(
      children: [
        linha('Cabecas', '${r.cabecas}'),
        linha('Peso total', formatKg(r.pesoTotalG)),
        linha('Peso medio', formatKg(r.pesoMedioG)),
        if (r.cfg.criterio == CriterioBase.arroba)
          linha('Arrobas totais', formatArrobas(r.arrobasTotalCentesimos)),
        linha('Valor medio por cabeca', formatBrl(r.valorMedioCentavos)),
        pw.Divider(),
        linha('VALOR TOTAL DO LOTE', formatBrl(r.valorTotalCentavos),
            destaque: true),
      ],
    ),
  );
}

/// Nome de arquivo seguro, derivado do nome do lote.
String nomeArquivoPdf(String loteNome) {
  final slug = loteNome
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return 'probov-${slug.isEmpty ? 'lote' : slug}.pdf';
}

/// Abre o share sheet nativo com o PDF. Funciona offline.
Future<void> compartilharPdf(ReportData r) async {
  final bytes = await gerarPdfRelatorio(r);
  await Printing.sharePdf(bytes: bytes, filename: nomeArquivoPdf(r.loteNome));
}
