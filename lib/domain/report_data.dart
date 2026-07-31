import '../core/units.dart';
import 'pricing.dart';

/// Um animal como entrada de cálculo — o mínimo que a precificação e o
/// relatório precisam. Não é a linha do banco: `domain/` não conhece Drift.
class AnimalInput {
  final int id;
  final int sequencia;
  final int pesoG;
  final String? brinco;
  final String? raca;
  final String? sexo;

  const AnimalInput({
    required this.id,
    required this.sequencia,
    required this.pesoG,
    this.brinco,
    this.raca,
    this.sexo,
  });
}

/// Uma linha do relatório, com o preço que de fato foi aplicado ao animal —
/// o cliente precisa ver *por que* aquele valor saiu, não só o valor.
class LinhaRelatorio {
  final int animalId;
  final int sequencia;
  final String? brinco;
  final String? raca;
  final int pesoG;
  final int arrobasCentesimos;
  final int precoAplicadoCentavos;
  final int valorCentavos;

  const LinhaRelatorio({
    required this.animalId,
    required this.sequencia,
    required this.brinco,
    required this.raca,
    required this.pesoG,
    required this.arrobasCentesimos,
    required this.precoAplicadoCentavos,
    required this.valorCentavos,
  });
}

/// O relatório inteiro como dado puro. O layout do PDF e a tela apenas
/// desenham isto; nenhum número é calculado na camada de apresentação.
class ReportData {
  final String loteNome;
  final DateTime data;
  final String? contraparte;
  final PrecoConfig cfg;
  final List<LinhaRelatorio> linhas;

  const ReportData({
    required this.loteNome,
    required this.data,
    required this.contraparte,
    required this.cfg,
    required this.linhas,
  });

  int get cabecas => linhas.length;

  int get pesoTotalG => linhas.fold(0, (s, l) => s + l.pesoG);

  int get arrobasTotalCentesimos =>
      linhas.fold(0, (s, l) => s + l.arrobasCentesimos);

  /// Soma dos valores já arredondados por animal. É assim que uma nota fecha:
  /// o cliente confere linha por linha e o total tem que dar exatamente.
  int get valorTotalCentavos => linhas.fold(0, (s, l) => s + l.valorCentavos);

  int get pesoMedioG => cabecas == 0 ? 0 : divArredondado(pesoTotalG, cabecas);

  int get valorMedioCentavos =>
      cabecas == 0 ? 0 : divArredondado(valorTotalCentavos, cabecas);
}

ReportData montarRelatorio({
  required String loteNome,
  required DateTime data,
  String? contraparte,
  required PrecoConfig cfg,
  required List<AnimalInput> animais,
}) {
  final linhas = animais.map((a) {
    final p = resolverPreco(cfg, pesoG: a.pesoG, raca: a.raca);
    return LinhaRelatorio(
      animalId: a.id,
      sequencia: a.sequencia,
      brinco: a.brinco,
      raca: a.raca,
      pesoG: a.pesoG,
      arrobasCentesimos:
          arrobasCentesimos(pesoG: a.pesoG, rendimentoBp: p.rendimentoBp),
      precoAplicadoCentavos: p.precoCentavos,
      valorCentavos: precificar(cfg, pesoG: a.pesoG, raca: a.raca),
    );
  }).toList(growable: false);

  return ReportData(
    loteNome: loteNome,
    data: data,
    contraparte: contraparte,
    cfg: cfg,
    linhas: linhas,
  );
}
