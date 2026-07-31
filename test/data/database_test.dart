import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:probov/data/database.dart';
import 'package:probov/domain/pricing.dart';

import '../helpers/db.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = dbDeTeste());
  tearDown(() => db.close());

  Future<int> inserirLote() => db.into(db.lotes).insert(
        LotesCompanion.insert(
          nome: 'Boiada Janeiro',
          data: DateTime(2026, 7, 31),
          criterioBase: CriterioBase.arroba,
          precoBaseCentavos: 32000,
          criadoEm: DateTime(2026, 7, 31),
          atualizadoEm: DateTime(2026, 7, 31),
        ),
      );

  test('grava e le um lote com o criterio como enum', () async {
    final id = await inserirLote();
    final lote =
        await (db.select(db.lotes)..where((t) => t.id.equals(id))).getSingle();
    expect(lote.nome, 'Boiada Janeiro');
    expect(lote.criterioBase, CriterioBase.arroba);
    expect(lote.rendimentoBp, 5200, reason: 'default do schema');
  });

  test('excluir o lote apaga animais e regras em cascata', () async {
    final loteId = await inserirLote();
    await db.into(db.animais).insert(AnimaisCompanion.insert(
          loteId: loteId,
          sequencia: 1,
          pesoG: 480000,
          criadoEm: DateTime(2026, 7, 31),
        ));
    await db.into(db.regrasPreco).insert(RegrasPrecoCompanion.insert(
          loteId: loteId,
          ordem: 0,
          precoCentavos: 33000,
        ));

    await (db.delete(db.lotes)..where((t) => t.id.equals(loteId))).go();

    expect(await db.select(db.animais).get(), isEmpty);
    expect(await db.select(db.regrasPreco).get(), isEmpty);
  });

  test('o schema esta na versao 1', () {
    expect(db.schemaVersion, 1);
  });
}
