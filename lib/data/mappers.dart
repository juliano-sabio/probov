import '../domain/pricing.dart';
import '../domain/report_data.dart';
import 'database.dart';

/// Monta a configuração de preço do domínio a partir das linhas do banco.
/// As regras precisam chegar já ordenadas por `ordem`.
PrecoConfig configDoLote(LoteRow lote, List<RegraPrecoRow> regras) => PrecoConfig(
      criterio: lote.criterioBase,
      precoBaseCentavos: lote.precoBaseCentavos,
      rendimentoBp: lote.rendimentoBp,
      regras: regras
          .map((r) => RegraPreco(
                pesoMinG: r.pesoMinG,
                pesoMaxG: r.pesoMaxG,
                raca: r.raca,
                precoCentavos: r.precoCentavos,
                rendimentoBp: r.rendimentoBp,
              ))
          .toList(growable: false),
    );

AnimalInput animalInputDe(AnimalRow a) => AnimalInput(
      id: a.id,
      sequencia: a.sequencia,
      pesoG: a.pesoG,
      brinco: a.brinco,
      raca: a.raca,
      sexo: a.sexo,
    );
