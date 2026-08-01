import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../providers.dart';
import '../pesagem/pesagem_screen.dart';
import 'lote_form_screen.dart';

class LotesScreen extends ConsumerWidget {
  const LotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotes = ref.watch(lotesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Probov')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoteFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Novo lote'),
      ),
      body: lotes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro ao carregar: $e')),
        data: (lista) {
          if (lista.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Nenhum lote ainda.\nToque em "Novo lote" para comecar a pesar.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: lista.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final l = lista[i];
              return _LoteTile(loteId: l.id, nome: l.nome, data: l.data);
            },
          );
        },
      ),
    );
  }
}

class _LoteTile extends ConsumerWidget {
  final int loteId;
  final String nome;
  final DateTime data;

  const _LoteTile({
    required this.loteId,
    required this.nome,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = ref.watch(relatorioProvider(loteId)).valueOrNull;
    final resumo = r == null
        ? 'calculando...'
        : '${r.cabecas} cab.  -  ${formatBrl(r.valorTotalCentavos)}';

    return ListTile(
      title: Text(nome),
      subtitle: Text('${formatData(data)}\n$resumo'),
      isThreeLine: true,
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: 'Excluir lote',
        onPressed: () => _confirmarExclusao(context, ref),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PesagemScreen(loteId: loteId)),
      ),
    );
  }

  Future<void> _confirmarExclusao(BuildContext context, WidgetRef ref) async {
    // Exclusão de lote é destrutiva e não tem undo (leva animais e regras em
    // cascata), então aqui a confirmação é explícita — diferente da exclusão
    // de um animal, que usa SnackBar com desfazer.
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Excluir "$nome"?'),
        content: const Text(
          'Todos os animais e regras de preco deste lote serao apagados. '
          'Nao da para desfazer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (ok ?? false) {
      await ref.read(loteRepoProvider).excluir(loteId);
    }
  }
}
