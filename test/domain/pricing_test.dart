import 'package:flutter_test/flutter_test.dart';
import 'package:probov/domain/pricing.dart';

void main() {
  const porArroba = PrecoConfig(
    criterio: CriterioBase.arroba,
    precoBaseCentavos: 32000, // R$ 320,00 por arroba
    rendimentoBp: 5200, // 52%
    regras: [],
  );

  group('criterio ARROBA', () {
    test('480 kg a 52% e R\$ 320,00 da R\$ 5.324,80', () {
      expect(precificar(porArroba, pesoG: 480000), 532480);
    });

    test('rendimento 100% e a arroba sobre peso vivo', () {
      const pesoVivo = PrecoConfig(
        criterio: CriterioBase.arroba,
        precoBaseCentavos: 32000,
        rendimentoBp: 10000,
        regras: [],
      );
      // 480 / 15 = 32 arrobas; 32 * 320 = 10240
      expect(precificar(pesoVivo, pesoG: 480000), 1024000);
    });

    test('arrobas em centesimos', () {
      expect(arrobasCentesimos(pesoG: 480000, rendimentoBp: 5200), 1664);
    });
  });

  group('criterio KG', () {
    const porKg = PrecoConfig(
      criterio: CriterioBase.kg,
      precoBaseCentavos: 1250, // R$ 12,50 por kg
      rendimentoBp: 5200, // ignorado
      regras: [],
    );

    test('480,5 kg a R\$ 12,50 da R\$ 6.006,25', () {
      expect(precificar(porKg, pesoG: 480500), 600625);
    });

    test('arredonda para o centavo mais proximo', () {
      const trocado = PrecoConfig(
        criterio: CriterioBase.kg,
        precoBaseCentavos: 333, // R$ 3,33
        rendimentoBp: 5200,
        regras: [],
      );
      // 100,5 * 3,33 = 334,665 -> R$ 334,67
      expect(precificar(trocado, pesoG: 100500), 33467);
    });
  });

  group('criterio CABECA', () {
    const porCabeca = PrecoConfig(
      criterio: CriterioBase.cabeca,
      precoBaseCentavos: 250000, // R$ 2.500,00
      rendimentoBp: 5200,
      regras: [],
    );

    test('valor fixo independente do peso', () {
      expect(precificar(porCabeca, pesoG: 300000), 250000);
      expect(precificar(porCabeca, pesoG: 600000), 250000);
    });
  });

  group('resolucao de regras', () {
    const comRegras = PrecoConfig(
      criterio: CriterioBase.arroba,
      precoBaseCentavos: 32000,
      rendimentoBp: 5200,
      regras: [
        RegraPreco(pesoMinG: 500001, precoCentavos: 33500),
        RegraPreco(raca: 'Nelore', precoCentavos: 33000),
      ],
    );

    test('nenhuma regra casa e usa a base', () {
      expect(precificar(comRegras, pesoG: 480000, raca: 'Angus'), 532480);
    });

    test('a primeira regra que casa vence', () {
      // 520 kg cai na faixa de peso, mesmo sem raca
      // 520 * 0,52 / 15 = 18,026666@ * 335 = 6038,933 -> R$ 6.038,93
      expect(precificar(comRegras, pesoG: 520000), 603893);
    });

    test('regra de raca aplica quando a de peso nao casa', () {
      // 16,64@ * 330 = 5491,20
      expect(precificar(comRegras, pesoG: 480000, raca: 'Nelore'), 549120);
    });

    test('raca nula nao casa regra de raca', () {
      expect(precificar(comRegras, pesoG: 480000), 532480);
    });

    test('regra herda o rendimento do lote quando o proprio e nulo', () {
      final p = resolverPreco(comRegras, pesoG: 480000, raca: 'Nelore');
      expect(p.precoCentavos, 33000);
      expect(p.rendimentoBp, 5200);
    });

    test('regra com rendimento proprio sobrescreve o do lote', () {
      const cfg = PrecoConfig(
        criterio: CriterioBase.arroba,
        precoBaseCentavos: 32000,
        rendimentoBp: 5200,
        regras: [
          RegraPreco(raca: 'Angus', precoCentavos: 32000, rendimentoBp: 5400)
        ],
      );
      final p = resolverPreco(cfg, pesoG: 480000, raca: 'Angus');
      expect(p.rendimentoBp, 5400);
    });

    test('faixa e inclusiva nos dois extremos', () {
      const r = RegraPreco(pesoMinG: 450000, pesoMaxG: 500000, precoCentavos: 1);
      expect(r.casa(pesoG: 450000), isTrue);
      expect(r.casa(pesoG: 500000), isTrue);
      expect(r.casa(pesoG: 449999), isFalse);
      expect(r.casa(pesoG: 500001), isFalse);
    });
  });
}
