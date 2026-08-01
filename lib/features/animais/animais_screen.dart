import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/parse.dart';
import '../../domain/pricing.dart';
import '../../providers.dart';

class AnimaisScreen extends ConsumerWidget {
  final int loteId;
  const AnimaisScreen({super.key, required this.loteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatorio = ref.watch(relatorioProvider(loteId));

    return Scaffold(
      appBar: AppBar(title: const Text('Animais')),
      body: relatorio.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (r) {
          if (r.linhas.isEmpty) {
            return const Center(child: Text('Nenhum animal pesado ainda.'));
          }
          final mostrarArrobas = r.cfg.criterio == CriterioBase.arroba;
          return ListView.separated(
            itemCount: r.linhas.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final l = r.linhas[i];
              final detalhe = [
                formatKg(l.pesoG),
                if (mostrarArrobas) formatArrobas(l.arrobasCentesimos),
                if (l.raca != null) l.raca!,
              ].join('  -  ');

              return ListTile(
                leading: CircleAvatar(child: Text('${l.sequencia}')),
                title: Text(detalhe),
                subtitle: Text(l.brinco == null ? '' : 'Brinco ${l.brinco}'),
                trailing: Text(
                  formatBrl(l.valorCentavos),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => _editar(context, ref, l.animalId),
                onLongPress: () => _excluirComUndo(context, ref, l.animalId),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _editar(BuildContext context, WidgetRef ref, int animalId) async {
    final repo = ref.read(animalRepoProvider);
    final atual = await repo.porId(animalId);
    if (!context.mounted) return;

    final peso = TextEditingController(text: formatPesoParaCampo(atual.pesoG));
    final brinco = TextEditingController(text: atual.brinco ?? '');
    final raca = TextEditingController(text: atual.raca ?? '');

    final salvar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Animal ${atual.sequencia}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: peso,
              autofocus: true,
              decoration:
                  const InputDecoration(labelText: 'Peso', suffixText: 'kg'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: brinco,
              decoration: const InputDecoration(labelText: 'Brinco'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: raca,
              decoration: const InputDecoration(labelText: 'Raca'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (salvar ?? false) {
      final novoPeso = parsePesoG(peso.text);
      if (novoPeso == null || novoPeso <= 0) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Peso invalido. Nada foi alterado.')),
          );
        }
      } else {
        await repo.atualizar(
          animalId,
          pesoG: novoPeso,
          brinco: brinco.text.trim().isEmpty ? null : brinco.text.trim(),
          raca: raca.text.trim().isEmpty ? null : raca.text.trim(),
          sexo: atual.sexo,
        );
      }
    }

    peso.dispose();
    brinco.dispose();
    raca.dispose();
  }

  Future<void> _excluirComUndo(
      BuildContext context, WidgetRef ref, int animalId) async {
    final repo = ref.read(animalRepoProvider);
    final removido = await repo.porId(animalId);
    await repo.excluir(animalId);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Animal ${removido.sequencia} removido'),
        action: SnackBarAction(
          label: 'Desfazer',
          // Reinsere com um novo id e nova sequência. O ordinal de pesagem
          // pode mudar, o que é aceitável: o que o usuário quer desfazer é a
          // perda do peso, não preservar a numeração.
          onPressed: () => repo.inserir(
            loteId: removido.loteId,
            pesoG: removido.pesoG,
            brinco: removido.brinco,
            raca: removido.raca,
            sexo: removido.sexo,
          ),
        ),
      ),
    );
  }
}
