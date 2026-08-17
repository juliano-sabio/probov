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
            final cor = Theme.of(context).colorScheme;
            final texto = Theme.of(context).textTheme;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.scale_outlined,
                      size: 56,
                      color: cor.primary.withValues(alpha: 0.35),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Nenhum lote ainda',
                      style: texto.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Crie um lote para começar a pesar.',
                      textAlign: TextAlign.center,
                      style: texto.bodyMedium?.copyWith(
                        color: cor.onSurfaceVariant,
                      ),
                    ),
                  ],
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
    final cor = Theme.of(context).colorScheme;
    final texto = Theme.of(context).textTheme;

    return ListTile(
      title: Text(
        nome,
        style: texto.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          r == null
              ? formatData(data)
              : '${formatData(data)}  ·  ${r.cabecas} '
                    '${r.cabecas == 1 ? 'cabeça' : 'cabeças'}',
          style: texto.bodySmall?.copyWith(color: cor.onSurfaceVariant),
        ),
      ),
      // O valor do lote é o dado que a pessoa procura ao abrir a lista, então
      // ele fica na direita, com peso, e não misturado na terceira linha.
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            r == null ? '...' : formatBrl(r.valorTotalCentavos),
            style: texto.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: cor.primary,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir lote',
            onPressed: () => _confirmarExclusao(context, ref),
          ),
        ],
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
          'Todos os animais e regras de preço deste lote serão apagados. '
          'Não dá para desfazer.',
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
