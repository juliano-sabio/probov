import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:probov/data/repositories.dart';
import 'package:probov/domain/pricing.dart';
import 'package:probov/domain/report_data.dart';
import 'package:probov/providers.dart';

import 'helpers/db.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = dbDeTeste();
    container = ProviderContainer(overrides: [dbProvider.overrideWithValue(db)]);
  });
  tearDown(() {
    container.dispose();
    db.close();
  });

  Future<int> loteComUmAnimal() async {
    final id = await LoteRepository(db).criar(
      nome: 'Boiada Janeiro',
      data: DateTime(2026, 7, 31),
      criterio: CriterioBase.arroba,
      precoBaseCentavos: 32000,
      rendimentoBp: 5200,
    );
    await AnimalRepository(db).inserir(loteId: id, pesoG: 480000);
    return id;
  }

  /// Espera o relatório satisfazer [condicao] e devolve.
  ///
  /// Não basta esperar sair de loading: quando o provider já está aquecido com
  /// o valor anterior, `read()` devolve o dado velho na hora e o teste passaria
  /// a medir o estado de antes da escrita.
  Future<ReportData> aguardar(
    ProviderContainer c,
    int loteId,
    bool Function(ReportData) condicao,
  ) async {
    final sub = c.listen(relatorioProvider(loteId), (_, _) {});
    for (var i = 0; i < 200; i++) {
      final v = sub.read();
      if (v is AsyncData<ReportData> && condicao(v.value)) return v.value;
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }
    fail('relatorio nao atingiu a condicao em 1s (ultimo: ${sub.read()})');
  }

  Future<ReportData> lerRelatorio(ProviderContainer c, int loteId) =>
      aguardar(c, loteId, (_) => true);

  /// Espera o total mudar em relação a [totalAnterior]. A asserção do valor
  /// novo fica no teste, não aqui — esperar pelo valor esperado tornaria a
  /// verificação circular.
  Future<ReportData> aguardarMudanca(
    ProviderContainer c,
    int loteId,
    int totalAnterior,
  ) =>
      aguardar(c, loteId, (r) => r.valorTotalCentavos != totalAnterior);

  test('relatorio reflete o animal inserido', () async {
    final id = await loteComUmAnimal();
    final r = await lerRelatorio(container, id);
    expect(r.cabecas, 1);
    expect(r.valorTotalCentavos, 532480);
  });

  test('editar o peso atualiza o total sem invalidacao manual', () async {
    final id = await loteComUmAnimal();
    var r = await lerRelatorio(container, id);
    final animalId = r.linhas.single.animalId;
    final totalAntes = r.valorTotalCentavos;

    await AnimalRepository(db).atualizarPeso(animalId, 520000);

    r = await aguardarMudanca(container, id, totalAntes);
    expect(r.valorTotalCentavos, 576853);
  });

  test('mudar o rendimento do lote atualiza o total', () async {
    final id = await loteComUmAnimal();
    await LoteRepository(db).atualizarPreco(id, rendimentoBp: 10000);
    final r = await lerRelatorio(container, id);
    // 480 / 15 = 32 arrobas * 320 = 10240
    expect(r.valorTotalCentavos, 1024000);
  });

  test('adicionar regra de raca muda o valor do animal que casa', () async {
    final id = await loteComUmAnimal();
    final inicial = await lerRelatorio(container, id);
    final animalId = inicial.linhas.single.animalId;
    final totalAntes = inicial.valorTotalCentavos;

    await AnimalRepository(db).atualizar(animalId, pesoG: 480000, raca: 'Nelore');
    await RegraRepository(db).substituirRegras(
        id, const [RegraPreco(raca: 'Nelore', precoCentavos: 33000)]);

    final r = await aguardarMudanca(container, id, totalAntes);
    expect(r.linhas.single.precoAplicadoCentavos, 33000);
    expect(r.valorTotalCentavos, 549120);
  });
}
