import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/parse.dart';
import '../../domain/pricing.dart';
import '../../providers.dart';

class RegrasScreen extends ConsumerStatefulWidget {
  final int loteId;
  const RegrasScreen({super.key, required this.loteId});

  @override
  ConsumerState<RegrasScreen> createState() => _RegrasScreenState();
}

class _RegrasScreenState extends ConsumerState<RegrasScreen> {
  List<RegraPreco>? _regras;

  @override
  Widget build(BuildContext context) {
    final doBanco = ref.watch(regrasProvider(widget.loteId));

    // Carrega uma vez para uma lista local editável; a tela só grava no
    // banco quando o usuário salva, e a gravação substitui o conjunto inteiro.
    final regras = _regras ??= doBanco.valueOrNull
        ?.map((r) => RegraPreco(
              pesoMinG: r.pesoMinG,
              pesoMaxG: r.pesoMaxG,
              raca: r.raca,
              precoCentavos: r.precoCentavos,
              rendimentoBp: r.rendimentoBp,
            ))
        .toList();

    if (regras == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Regras de preço'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref
                  .read(regraRepoProvider)
                  .substituirRegras(widget.loteId, regras);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editarRegra(null),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'A primeira regra que casar com o animal define o preço. '
              'Arraste para reordenar. Sem nenhuma regra, vale o preço base do lote.',
            ),
          ),
          Expanded(
            child: regras.isEmpty
                ? const Center(child: Text('Nenhuma regra.'))
                : ReorderableListView.builder(
                    itemCount: regras.length,
                    onReorder: (de, para) => setState(() {
                      if (para > de) para -= 1;
                      final r = regras.removeAt(de);
                      regras.insert(para, r);
                    }),
                    itemBuilder: (context, i) {
                      final r = regras[i];
                      return ListTile(
                        key: ValueKey('regra-$i-${r.precoCentavos}'),
                        leading: CircleAvatar(child: Text('${i + 1}')),
                        title: Text(_descricaoCondicao(r)),
                        subtitle: Text(_descricaoPreco(r)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => setState(() => regras.removeAt(i)),
                        ),
                        onTap: () => _editarRegra(i),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _descricaoCondicao(RegraPreco r) {
    final partes = <String>[];
    if (r.pesoMinG != null && r.pesoMaxG != null) {
      partes.add('de ${formatKg(r.pesoMinG!)} a ${formatKg(r.pesoMaxG!)}');
    } else if (r.pesoMinG != null) {
      partes.add('a partir de ${formatKg(r.pesoMinG!)}');
    } else if (r.pesoMaxG != null) {
      partes.add('ate ${formatKg(r.pesoMaxG!)}');
    }
    if (r.raca != null) partes.add('raça ${r.raca}');
    return partes.isEmpty ? 'Qualquer animal' : partes.join('  -  ');
  }

  String _descricaoPreco(RegraPreco r) {
    final preco = formatBrl(r.precoCentavos);
    return r.rendimentoBp == null
        ? preco
        : '$preco  -  rendimento ${formatPercentBp(r.rendimentoBp!)}';
  }

  Future<void> _editarRegra(int? indice) async {
    final atual = indice == null ? null : _regras![indice];
    final nova = await showDialog<RegraPreco>(
      context: context,
      builder: (_) => _RegraDialog(inicial: atual),
    );
    if (nova == null) return;
    setState(() {
      if (indice == null) {
        _regras!.add(nova);
      } else {
        _regras![indice] = nova;
      }
    });
  }
}

class _RegraDialog extends StatefulWidget {
  final RegraPreco? inicial;
  const _RegraDialog({this.inicial});

  @override
  State<_RegraDialog> createState() => _RegraDialogState();
}

class _RegraDialogState extends State<_RegraDialog> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _min;
  late final TextEditingController _max;
  late final TextEditingController _raca;
  late final TextEditingController _preco;
  late final TextEditingController _rendimento;

  @override
  void initState() {
    super.initState();
    final r = widget.inicial;
    _min = TextEditingController(
        text: r?.pesoMinG == null ? '' : formatPesoParaCampo(r!.pesoMinG!));
    _max = TextEditingController(
        text: r?.pesoMaxG == null ? '' : formatPesoParaCampo(r!.pesoMaxG!));
    _raca = TextEditingController(text: r?.raca ?? '');
    _preco = TextEditingController(
        text: r == null ? '' : formatCentavosParaCampo(r.precoCentavos));
    _rendimento = TextEditingController(
        text:
            r?.rendimentoBp == null ? '' : formatBpParaCampo(r!.rendimentoBp!));
  }

  @override
  void dispose() {
    _min.dispose();
    _max.dispose();
    _raca.dispose();
    _preco.dispose();
    _rendimento.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const numerico = TextInputType.numberWithOptions(decimal: true);
    final soNumero = [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))];

    return AlertDialog(
      title: const Text('Regra de preço'),
      content: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _min,
                      decoration: const InputDecoration(
                          labelText: 'Peso min', suffixText: 'kg'),
                      keyboardType: numerico,
                      inputFormatters: soNumero,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _max,
                      decoration: const InputDecoration(
                          labelText: 'Peso max', suffixText: 'kg'),
                      keyboardType: numerico,
                      inputFormatters: soNumero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _raca,
                decoration: const InputDecoration(labelText: 'Raça'),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _preco,
                decoration: const InputDecoration(
                    labelText: 'Preço', prefixText: 'R\$ '),
                keyboardType: numerico,
                inputFormatters: soNumero,
                validator: (v) =>
                    parseCentavos(v ?? '') == null ? 'Preço inválido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _rendimento,
                decoration: const InputDecoration(
                  labelText: 'Rendimento',
                  suffixText: '%',
                  helperText: 'Vazio herda o do lote',
                ),
                keyboardType: numerico,
                inputFormatters: soNumero,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _confirmar, child: const Text('OK')),
      ],
    );
  }

  void _confirmar() {
    if (!(_form.currentState?.validate() ?? false)) return;

    final min = parsePesoG(_min.text);
    final max = parsePesoG(_max.text);

    // Faixa invertida é bloqueada aqui, não no domínio: uma regra com
    // min > max nunca casaria e o usuário nunca entenderia por que.
    if (min != null && max != null && min > max) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('O peso mínimo não pode ser maior que o máximo.')),
      );
      return;
    }

    final raca = _raca.text.trim();
    Navigator.pop(
      context,
      RegraPreco(
        pesoMinG: min,
        pesoMaxG: max,
        raca: raca.isEmpty ? null : raca,
        precoCentavos: parseCentavos(_preco.text)!,
        rendimentoBp: parseCentavos(_rendimento.text),
      ),
    );
  }
}
