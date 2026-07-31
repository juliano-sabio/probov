import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database.dart';
import 'data/repositories.dart';
import 'domain/report_data.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final loteRepoProvider =
    Provider((ref) => LoteRepository(ref.watch(dbProvider)));
final animalRepoProvider =
    Provider((ref) => AnimalRepository(ref.watch(dbProvider)));
final regraRepoProvider =
    Provider((ref) => RegraRepository(ref.watch(dbProvider)));

final lotesProvider = StreamProvider<List<LoteRow>>(
    (ref) => ref.watch(loteRepoProvider).watchLotes());

final loteProvider = StreamProvider.family<LoteRow, int>(
    (ref, loteId) => ref.watch(loteRepoProvider).watchLote(loteId));

final regrasProvider = StreamProvider.family<List<RegraPrecoRow>, int>(
    (ref, loteId) => ref.watch(regraRepoProvider).watchRegras(loteId));

final animaisProvider = StreamProvider.family<List<AnimalRow>, int>(
    (ref, loteId) => ref.watch(animalRepoProvider).watchAnimais(loteId));

/// O relatório do lote, derivado dos três streams.
///
/// Nenhum valor monetário é lido do banco: o dinheiro é sempre calculado aqui
/// pela função pura. É por isso que editar peso, preço, rendimento, raça ou
/// regra atualiza tela, relatório e PDF juntos — não existe cópia do número
/// para ficar velha.
final relatorioProvider =
    Provider.family<AsyncValue<ReportData>, int>((ref, loteId) {
  final lote = ref.watch(loteProvider(loteId));
  final regras = ref.watch(regrasProvider(loteId));
  final animais = ref.watch(animaisProvider(loteId));

  for (final v in [lote, regras, animais]) {
    if (v.hasError) {
      return AsyncError(v.error!, v.stackTrace ?? StackTrace.empty);
    }
  }

  final l = lote.valueOrNull;
  final r = regras.valueOrNull;
  final a = animais.valueOrNull;
  if (l == null || r == null || a == null) return const AsyncLoading();

  return AsyncData(montarRelatorio(
    loteNome: l.nome,
    data: l.data,
    contraparte: l.contraparte,
    cfg: configDoLote(l, r),
    animais: a.map(animalInputDe).toList(growable: false),
  ));
});

/// Total de um lote, para a lista da home. Reusa o mesmo cálculo do relatório
/// em vez de duplicar a lógica de soma.
final totalLoteProvider = Provider.family<AsyncValue<int>, int>((ref, loteId) =>
    ref.watch(relatorioProvider(loteId)).whenData((r) => r.valorTotalCentavos));
