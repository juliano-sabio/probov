import 'package:flutter_test/flutter_test.dart';
import 'package:probov/domain/pricing.dart';
import 'package:probov/domain/report_data.dart';

void main() {
  const cfg = PrecoConfig(
    criterio: CriterioBase.arroba,
    precoBaseCentavos: 32000,
    rendimentoBp: 5200,
    regras: [],
  );

  ReportData montar(List<AnimalInput> animais) => montarRelatorio(
        loteNome: 'Boiada Janeiro',
        data: DateTime(2026, 7, 31),
        contraparte: 'Fazenda Boa Vista',
        cfg: cfg,
        animais: animais,
      );

  test('lote vazio tem totais zerados e nao lanca', () {
    final r = montar([]);
    expect(r.cabecas, 0);
    expect(r.pesoTotalG, 0);
    expect(r.pesoMedioG, 0);
    expect(r.valorTotalCentavos, 0);
    expect(r.valorMedioCentavos, 0);
    expect(r.arrobasTotalCentesimos, 0);
  });

  test('dois animais somam peso, arrobas e valor', () {
    final r = montar(const [
      AnimalInput(id: 1, sequencia: 1, pesoG: 480000),
      AnimalInput(id: 2, sequencia: 2, pesoG: 520000),
    ]);
    expect(r.cabecas, 2);
    expect(r.pesoTotalG, 1000000);
    expect(r.pesoMedioG, 500000);
    // 480kg -> 532480 ; 520kg: 520*0,52/15 = 18,026666@ * 320 = 5768,53
    expect(r.linhas[0].valorCentavos, 532480);
    expect(r.linhas[1].valorCentavos, 576853);
    expect(r.valorTotalCentavos, 532480 + 576853);
    expect(r.valorMedioCentavos, divMedio(532480 + 576853, 2));
  });

  test('o total e a soma dos valores ja arredondados', () {
    // Cada linha e arredondada uma vez; o total nunca re-arredonda.
    final r = montar(const [
      AnimalInput(id: 1, sequencia: 1, pesoG: 100500),
      AnimalInput(id: 2, sequencia: 2, pesoG: 100500),
    ]);
    expect(r.valorTotalCentavos, r.linhas[0].valorCentavos * 2);
  });

  test('a linha registra o preco aplicado, nao o preco base', () {
    const comRegra = PrecoConfig(
      criterio: CriterioBase.arroba,
      precoBaseCentavos: 32000,
      rendimentoBp: 5200,
      regras: [RegraPreco(raca: 'Nelore', precoCentavos: 33000)],
    );
    final r = montarRelatorio(
      loteNome: 'L',
      data: DateTime(2026, 7, 31),
      cfg: comRegra,
      animais: const [
        AnimalInput(id: 1, sequencia: 1, pesoG: 480000, raca: 'Nelore'),
      ],
    );
    expect(r.linhas[0].precoAplicadoCentavos, 33000);
    expect(r.linhas[0].valorCentavos, 549120);
  });
}

/// Média inteira arredondada, replicada no teste para deixar o número explícito.
int divMedio(int total, int n) => (total + n ~/ 2) ~/ n;
