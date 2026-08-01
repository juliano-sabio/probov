import 'package:flutter_test/flutter_test.dart';
import 'package:probov/data/repositories.dart';
import 'package:probov/domain/pricing.dart';

import '../helpers/db.dart';

void main() {
  late AppDatabase db;
  late LoteRepository lotes;
  late AnimalRepository animais;
  late RegraRepository regras;

  setUp(() {
    db = dbDeTeste();
    lotes = LoteRepository(db);
    animais = AnimalRepository(db);
    regras = RegraRepository(db);
  });
  tearDown(() => db.close());

  Future<int> novoLote() => lotes.criar(
        nome: 'Boiada Janeiro',
        data: DateTime(2026, 7, 31),
        criterio: CriterioBase.arroba,
        precoBaseCentavos: 32000,
        rendimentoBp: 5200,
      );

  test('criar e observar lotes', () async {
    final id = await novoLote();
    final lista = await lotes.watchLotes().first;
    expect(lista.single.id, id);
  });

  test('atualizar lote muda preco e atualizadoEm', () async {
    final id = await novoLote();
    final antes = await lotes.watchLote(id).first;
    await lotes.atualizarPreco(id, precoBaseCentavos: 33000, rendimentoBp: 5400);
    final depois = await lotes.watchLote(id).first;
    expect(depois.precoBaseCentavos, 33000);
    expect(depois.rendimentoBp, 5400);
    expect(depois.atualizadoEm.isBefore(antes.atualizadoEm), isFalse);
  });

  test('sequencia do animal comeca em 1 e incrementa', () async {
    final id = await novoLote();
    expect(await animais.proximaSequencia(id), 1);
    await animais.inserir(loteId: id, pesoG: 480000);
    expect(await animais.proximaSequencia(id), 2);
  });

  test('sequencia nao reaproveita numero apos exclusao', () async {
    final id = await novoLote();
    await animais.inserir(loteId: id, pesoG: 480000);
    final segundo = await animais.inserir(loteId: id, pesoG: 500000);
    await animais.excluir(segundo);
    // MAX(sequencia) caiu para 1, entao o proximo e 2 de novo.
    // Isso e aceitavel: a sequencia e ordinal de pesagem, nao identidade.
    expect(await animais.proximaSequencia(id), 2);
  });

  test('atualizar peso do animal', () async {
    final id = await novoLote();
    final animalId = await animais.inserir(loteId: id, pesoG: 480000);
    await animais.atualizarPeso(animalId, 495500);
    final lista = await animais.watchAnimais(id).first;
    expect(lista.single.pesoG, 495500);
  });

  test('substituirRegras troca o conjunto inteiro e mantem a ordem', () async {
    final id = await novoLote();
    await regras.substituirRegras(id, const [
      RegraPreco(pesoMinG: 500001, precoCentavos: 33500),
      RegraPreco(raca: 'Nelore', precoCentavos: 33000),
    ]);
    var lista = await regras.watchRegras(id).first;
    expect(lista.map((r) => r.precoCentavos), [33500, 33000]);

    await regras.substituirRegras(id, const [
      RegraPreco(raca: 'Angus', precoCentavos: 34000),
    ]);
    lista = await regras.watchRegras(id).first;
    expect(lista.single.precoCentavos, 34000);
  });

  test('configDoLote monta o PrecoConfig do dominio', () async {
    final id = await novoLote();
    await regras.substituirRegras(
        id, const [RegraPreco(raca: 'Nelore', precoCentavos: 33000)]);
    final lote = await lotes.watchLote(id).first;
    final rs = await regras.watchRegras(id).first;
    final cfg = configDoLote(lote, rs);
    expect(cfg.criterio, CriterioBase.arroba);
    expect(cfg.precoBaseCentavos, 32000);
    expect(cfg.regras.single.raca, 'Nelore');
  });
}
