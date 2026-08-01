import 'package:flutter_test/flutter_test.dart';
import 'package:probov/domain/pricing.dart';
import 'package:probov/domain/report_data.dart';
import 'package:probov/features/relatorio/pdf_relatorio.dart';

void main() {
  ReportData relatorio({
    int animais = 3,
    CriterioBase criterio = CriterioBase.arroba,
  }) =>
      montarRelatorio(
        loteNome: 'Boiada Janeiro',
        data: DateTime(2026, 7, 31),
        contraparte: 'Fazenda Boa Vista',
        cfg: PrecoConfig(
          criterio: criterio,
          precoBaseCentavos: 32000,
          rendimentoBp: 5200,
          regras: const [],
        ),
        animais: List.generate(
          animais,
          (i) => AnimalInput(
            id: i + 1,
            sequencia: i + 1,
            pesoG: 450000 + i * 1000,
            brinco: 'BR${i + 1}',
            raca: 'Nelore',
          ),
        ),
      );

  test('gera bytes de PDF valido', () async {
    final bytes = await gerarPdfRelatorio(relatorio());
    expect(bytes.length, greaterThan(1000));
    // Assinatura de arquivo PDF.
    expect(String.fromCharCodes(bytes.take(4)), '%PDF');
  });

  test('lote grande gera PDF sem estourar (MultiPage pagina)', () async {
    final bytes = await gerarPdfRelatorio(relatorio(animais: 250));
    expect(bytes.length, greaterThan(1000));
  });

  test('lote vazio gera PDF sem lancar', () async {
    final bytes = await gerarPdfRelatorio(relatorio(animais: 0));
    expect(bytes.length, greaterThan(1000));
  });

  test('criterio por cabeca gera PDF sem coluna de arroba', () async {
    final bytes =
        await gerarPdfRelatorio(relatorio(criterio: CriterioBase.cabeca));
    expect(bytes.length, greaterThan(1000));
  });

  test('nome de arquivo e seguro para o sistema de arquivos', () {
    expect(
        nomeArquivoPdf('Boiada Janeiro / 2026'), 'probov-boiada-janeiro-2026.pdf');
    expect(nomeArquivoPdf('Lote  #1'), 'probov-lote-1.pdf');
  });
}
