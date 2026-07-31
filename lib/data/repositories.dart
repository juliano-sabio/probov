import 'package:drift/drift.dart';

import '../domain/pricing.dart';
import 'database.dart';

export 'database.dart';
export 'mappers.dart';

class LoteRepository {
  final AppDatabase db;
  LoteRepository(this.db);

  Stream<List<LoteRow>> watchLotes() =>
      (db.select(db.lotes)..orderBy([(t) => OrderingTerm.desc(t.data)])).watch();

  Stream<LoteRow> watchLote(int id) =>
      (db.select(db.lotes)..where((t) => t.id.equals(id))).watchSingle();

  Future<int> criar({
    required String nome,
    required DateTime data,
    required CriterioBase criterio,
    required int precoBaseCentavos,
    required int rendimentoBp,
    String? contraparte,
    String? racaPadrao,
    String? obs,
  }) {
    final agora = DateTime.now();
    return db.into(db.lotes).insert(LotesCompanion.insert(
          nome: nome,
          data: data,
          criterioBase: criterio,
          precoBaseCentavos: precoBaseCentavos,
          rendimentoBp: Value(rendimentoBp),
          contraparte: Value(contraparte),
          racaPadrao: Value(racaPadrao),
          obs: Value(obs),
          criadoEm: agora,
          atualizadoEm: agora,
        ));
  }

  Future<void> atualizarPreco(
    int id, {
    CriterioBase? criterio,
    int? precoBaseCentavos,
    int? rendimentoBp,
  }) =>
      (db.update(db.lotes)..where((t) => t.id.equals(id))).write(
        LotesCompanion(
          criterioBase:
              criterio == null ? const Value.absent() : Value(criterio),
          precoBaseCentavos: precoBaseCentavos == null
              ? const Value.absent()
              : Value(precoBaseCentavos),
          rendimentoBp:
              rendimentoBp == null ? const Value.absent() : Value(rendimentoBp),
          atualizadoEm: Value(DateTime.now()),
        ),
      );

  Future<void> atualizarIdentificacao(
    int id, {
    required String nome,
    required DateTime data,
    String? contraparte,
    String? racaPadrao,
    String? obs,
  }) =>
      (db.update(db.lotes)..where((t) => t.id.equals(id))).write(
        LotesCompanion(
          nome: Value(nome),
          data: Value(data),
          contraparte: Value(contraparte),
          racaPadrao: Value(racaPadrao),
          obs: Value(obs),
          atualizadoEm: Value(DateTime.now()),
        ),
      );

  Future<void> excluir(int id) =>
      (db.delete(db.lotes)..where((t) => t.id.equals(id))).go();
}

class AnimalRepository {
  final AppDatabase db;
  AnimalRepository(this.db);

  Stream<List<AnimalRow>> watchAnimais(int loteId) => (db.select(db.animais)
        ..where((t) => t.loteId.equals(loteId))
        ..orderBy([(t) => OrderingTerm.asc(t.sequencia)]))
      .watch();

  /// A sequência é ordinal de pesagem, não identidade — se o último animal for
  /// excluído, o número dele é reaproveitado, e isso é o comportamento certo
  /// para quem está corrigindo um erro de digitação na balança.
  Future<int> proximaSequencia(int loteId) async {
    final maxSeq = db.animais.sequencia.max();
    final q = db.selectOnly(db.animais)
      ..addColumns([maxSeq])
      ..where(db.animais.loteId.equals(loteId));
    final row = await q.getSingle();
    return (row.read(maxSeq) ?? 0) + 1;
  }

  Future<int> inserir({
    required int loteId,
    required int pesoG,
    String? brinco,
    String? raca,
    String? sexo,
    String? obs,
  }) async {
    final seq = await proximaSequencia(loteId);
    return db.into(db.animais).insert(AnimaisCompanion.insert(
          loteId: loteId,
          sequencia: seq,
          pesoG: pesoG,
          brinco: Value(brinco),
          raca: Value(raca),
          sexo: Value(sexo),
          obs: Value(obs),
          criadoEm: DateTime.now(),
        ));
  }

  Future<void> atualizarPeso(int id, int pesoG) =>
      (db.update(db.animais)..where((t) => t.id.equals(id)))
          .write(AnimaisCompanion(pesoG: Value(pesoG)));

  Future<void> atualizar(
    int id, {
    required int pesoG,
    String? brinco,
    String? raca,
    String? sexo,
  }) =>
      (db.update(db.animais)..where((t) => t.id.equals(id))).write(
        AnimaisCompanion(
          pesoG: Value(pesoG),
          brinco: Value(brinco),
          raca: Value(raca),
          sexo: Value(sexo),
        ),
      );

  Future<AnimalRow> porId(int id) =>
      (db.select(db.animais)..where((t) => t.id.equals(id))).getSingle();

  Future<void> excluir(int id) =>
      (db.delete(db.animais)..where((t) => t.id.equals(id))).go();
}

class RegraRepository {
  final AppDatabase db;
  RegraRepository(this.db);

  Stream<List<RegraPrecoRow>> watchRegras(int loteId) =>
      (db.select(db.regrasPreco)
            ..where((t) => t.loteId.equals(loteId))
            ..orderBy([(t) => OrderingTerm.asc(t.ordem)]))
          .watch();

  /// Apaga e regrava o conjunto inteiro numa transação. É mais simples e mais
  /// seguro que CRUD por linha: a ordem das regras é significativa (a primeira
  /// que casa vence), e reordenar por UPDATE individual passa por estados
  /// intermediários com ordem duplicada.
  Future<void> substituirRegras(int loteId, List<RegraPreco> regras) =>
      db.transaction(() async {
        await (db.delete(db.regrasPreco)..where((t) => t.loteId.equals(loteId)))
            .go();
        for (var i = 0; i < regras.length; i++) {
          final r = regras[i];
          await db.into(db.regrasPreco).insert(RegrasPrecoCompanion.insert(
                loteId: loteId,
                ordem: i,
                pesoMinG: Value(r.pesoMinG),
                pesoMaxG: Value(r.pesoMaxG),
                raca: Value(r.raca),
                precoCentavos: r.precoCentavos,
                rendimentoBp: Value(r.rendimentoBp),
              ));
        }
      });
}
