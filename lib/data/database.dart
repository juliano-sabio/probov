import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../domain/pricing.dart' show CriterioBase;

part 'database.g.dart';

@DataClassName('LoteRow')
class Lotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 1, max: 120)();
  DateTimeColumn get data => dateTime()();
  TextColumn get contraparte => text().nullable()();
  TextColumn get obs => text().nullable()();
  IntColumn get criterioBase => intEnum<CriterioBase>()();
  IntColumn get precoBaseCentavos => integer()();
  IntColumn get rendimentoBp => integer().withDefault(const Constant(5200))();

  /// Apenas pré-preenche a raça na tela de pesagem. A precificação não faz
  /// fallback do animal para o lote.
  TextColumn get racaPadrao => text().nullable()();

  DateTimeColumn get criadoEm => dateTime()();
  DateTimeColumn get atualizadoEm => dateTime()();
}

@DataClassName('RegraPrecoRow')
class RegrasPreco extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get loteId =>
      integer().references(Lotes, #id, onDelete: KeyAction.cascade)();
  IntColumn get ordem => integer()();
  IntColumn get pesoMinG => integer().nullable()();
  IntColumn get pesoMaxG => integer().nullable()();
  TextColumn get raca => text().nullable()();
  IntColumn get precoCentavos => integer()();
  IntColumn get rendimentoBp => integer().nullable()();
}

@DataClassName('AnimalRow')
class Animais extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get loteId =>
      integer().references(Lotes, #id, onDelete: KeyAction.cascade)();
  IntColumn get sequencia => integer()();
  IntColumn get pesoG => integer()();
  TextColumn get brinco => text().nullable()();
  TextColumn get raca => text().nullable()();
  TextColumn get sexo => text().nullable()();
  TextColumn get obs => text().nullable()();
  DateTimeColumn get criadoEm => dateTime()();
}

@DriftDatabase(tables: [Lotes, RegrasPreco, Animais])
class AppDatabase extends _$AppDatabase {
  /// Sem argumento abre o banco do app. Nos testes, passe
  /// `NativeDatabase.memory()`.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'probov'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // Sem isto o SQLite ignora as foreign keys e o ON DELETE CASCADE
          // não acontece — excluir um lote deixaria animais órfãos.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
