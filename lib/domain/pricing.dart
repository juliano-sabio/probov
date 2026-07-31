import '../core/units.dart';

/// Critério base de precificação de um lote.
///
/// `raça` e `faixa de peso` do requisito do cliente não são critérios: são
/// condições que escolhem *qual preço* aplicar, e vivem em [RegraPreco].
enum CriterioBase { arroba, kg, cabeca }

/// Regra que sobrescreve o preço base quando suas condições casam.
///
/// Campos de condição nulos não filtram — uma regra só com [raca] vale para
/// qualquer peso, e uma regra sem condição nenhuma casa com todo animal.
class RegraPreco {
  final int? pesoMinG;
  final int? pesoMaxG;
  final String? raca;
  final int precoCentavos;

  /// Nulo herda o rendimento do lote.
  final int? rendimentoBp;

  const RegraPreco({
    this.pesoMinG,
    this.pesoMaxG,
    this.raca,
    required this.precoCentavos,
    this.rendimentoBp,
  });

  /// A faixa é inclusiva nos dois extremos.
  bool casa({required int pesoG, String? raca}) {
    final min = pesoMinG;
    final max = pesoMaxG;
    final r = this.raca;
    if (min != null && pesoG < min) return false;
    if (max != null && pesoG > max) return false;
    if (r != null && r != raca) return false;
    return true;
  }
}

/// Tudo que define preço num lote: a base e as regras, já na ordem de avaliação.
class PrecoConfig {
  final CriterioBase criterio;
  final int precoBaseCentavos;
  final int rendimentoBp;
  final List<RegraPreco> regras;

  const PrecoConfig({
    required this.criterio,
    required this.precoBaseCentavos,
    required this.rendimentoBp,
    required this.regras,
  });
}

/// O preço e o rendimento efetivamente aplicados a um animal.
class PrecoAplicado {
  final int precoCentavos;
  final int rendimentoBp;
  const PrecoAplicado(this.precoCentavos, this.rendimentoBp);
}

/// A primeira regra que casa vence. Nenhuma casou, usa a base do lote.
PrecoAplicado resolverPreco(
  PrecoConfig cfg, {
  required int pesoG,
  String? raca,
}) {
  for (final r in cfg.regras) {
    if (r.casa(pesoG: pesoG, raca: raca)) {
      return PrecoAplicado(r.precoCentavos, r.rendimentoBp ?? cfg.rendimentoBp);
    }
  }
  return PrecoAplicado(cfg.precoBaseCentavos, cfg.rendimentoBp);
}

/// Arrobas em centésimos: 1664 é 16,64 arrobas.
///
/// Serve para exibição. O valor em dinheiro NÃO é calculado a partir daqui,
/// para não arredondar duas vezes.
int arrobasCentesimos({required int pesoG, required int rendimentoBp}) =>
    divArredondado(
        pesoG * rendimentoBp * 100, gramasPorKg * bpTotal * kgPorArroba);

/// Valor de um animal em centavos.
int precificar(PrecoConfig cfg, {required int pesoG, String? raca}) {
  final p = resolverPreco(cfg, pesoG: pesoG, raca: raca);
  switch (cfg.criterio) {
    case CriterioBase.cabeca:
      return p.precoCentavos;
    case CriterioBase.kg:
      return divArredondado(pesoG * p.precoCentavos, gramasPorKg);
    case CriterioBase.arroba:
      // Uma única divisão, um único arredondamento:
      // peso(g) * rendimento(bp) * preco(centavos) / (1000 * 10000 * 15)
      return divArredondado(
        pesoG * p.rendimentoBp * p.precoCentavos,
        gramasPorKg * bpTotal * kgPorArroba,
      );
  }
}
