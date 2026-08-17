import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/parse.dart';
import '../../domain/pricing.dart';
import '../../providers.dart';
import '../pesagem/pesagem_screen.dart';
import '../regras/regras_screen.dart';

class LoteFormScreen extends ConsumerStatefulWidget {
  /// Nulo cria um lote novo.
  final int? loteId;

  const LoteFormScreen({super.key, this.loteId});

  @override
  ConsumerState<LoteFormScreen> createState() => _LoteFormScreenState();
}

class _LoteFormScreenState extends ConsumerState<LoteFormScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _contraparte = TextEditingController();
  final _preco = TextEditingController();
  final _rendimento = TextEditingController(text: '52,0');
  final _racaPadrao = TextEditingController();

  DateTime _data = DateTime.now();
  CriterioBase _criterio = CriterioBase.arroba;
  bool _carregado = false;

  bool get _editando => widget.loteId != null;

  @override
  void dispose() {
    _nome.dispose();
    _contraparte.dispose();
    _preco.dispose();
    _rendimento.dispose();
    _racaPadrao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ao editar, preenche os campos uma única vez a partir do banco.
    if (_editando && !_carregado) {
      final lote = ref.watch(loteProvider(widget.loteId!));
      final l = lote.valueOrNull;
      if (l == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      _nome.text = l.nome;
      _contraparte.text = l.contraparte ?? '';
      _preco.text = formatCentavosParaCampo(l.precoBaseCentavos);
      _rendimento.text = formatBpParaCampo(l.rendimentoBp);
      _racaPadrao.text = l.racaPadrao ?? '';
      _data = l.data;
      _criterio = l.criterioBase;
      _carregado = true;
    }

    return Scaffold(
      appBar: AppBar(title: Text(_editando ? 'Editar lote' : 'Novo lote')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nome,
              decoration: const InputDecoration(labelText: 'Nome do lote'),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe um nome' : null,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data'),
              subtitle: Text(formatData(_data)),
              trailing: const Icon(Icons.calendar_today),
              onTap: _escolherData,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contraparte,
              decoration: const InputDecoration(
                labelText: 'Comprador / vendedor (opcional)',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),
            const Text('Critério de precificação'),
            const SizedBox(height: 8),
            SegmentedButton<CriterioBase>(
              segments: const [
                ButtonSegment(value: CriterioBase.arroba, label: Text('Arroba')),
                ButtonSegment(value: CriterioBase.kg, label: Text('Quilo')),
                ButtonSegment(value: CriterioBase.cabeca, label: Text('Cabeça')),
              ],
              selected: {_criterio},
              onSelectionChanged: (s) => setState(() => _criterio = s.first),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _preco,
              decoration: InputDecoration(
                labelText: 'Preço base',
                prefixText: 'R\$ ',
                suffixText: _sufixoPreco,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              validator: (v) =>
                  parseCentavos(v ?? '') == null ? 'Preço inválido' : null,
            ),
            if (_criterio == CriterioBase.arroba) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _rendimento,
                decoration: const InputDecoration(
                  labelText: 'Rendimento de carcaça',
                  suffixText: '%',
                  helperText: '100% equivale a arroba sobre peso vivo',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                validator: (v) {
                  final bp = parseCentavos(v ?? '');
                  if (bp == null || bp <= 0 || bp > 10000) {
                    return 'Informe de 0,1 a 100';
                  }
                  return null;
                },
              ),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _racaPadrao,
              decoration: const InputDecoration(
                labelText: 'Raça padrão (opcional)',
                helperText: 'Pré-preenche a raça de cada animal na pesagem',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            if (_editando) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegrasScreen(loteId: widget.loteId!),
                  ),
                ),
                icon: const Icon(Icons.rule),
                label: const Text('Regras por faixa de peso e raça'),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _salvar,
              child: Text(_editando ? 'Salvar' : 'Criar e começar a pesar'),
            ),
          ],
        ),
      ),
    );
  }

  String get _sufixoPreco => switch (_criterio) {
        CriterioBase.arroba => 'por @',
        CriterioBase.kg => 'por kg',
        CriterioBase.cabeca => 'por cabeça',
      };

  Future<void> _escolherData() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _data,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _data = d);
  }

  Future<void> _salvar() async {
    if (!(_form.currentState?.validate() ?? false)) return;

    final precoCentavos = parseCentavos(_preco.text)!;
    final rendimentoBp = _criterio == CriterioBase.arroba
        ? parseCentavos(_rendimento.text)!
        : 5200;
    final contraparte =
        _contraparte.text.trim().isEmpty ? null : _contraparte.text.trim();
    final racaPadrao =
        _racaPadrao.text.trim().isEmpty ? null : _racaPadrao.text.trim();

    final repo = ref.read(loteRepoProvider);

    if (_editando) {
      await repo.atualizarIdentificacao(
        widget.loteId!,
        nome: _nome.text.trim(),
        data: _data,
        contraparte: contraparte,
        racaPadrao: racaPadrao,
      );
      await repo.atualizarPreco(
        widget.loteId!,
        criterio: _criterio,
        precoBaseCentavos: precoCentavos,
        rendimentoBp: rendimentoBp,
      );
      if (mounted) Navigator.pop(context);
    } else {
      final id = await repo.criar(
        nome: _nome.text.trim(),
        data: _data,
        criterio: _criterio,
        precoBaseCentavos: precoCentavos,
        rendimentoBp: rendimentoBp,
        contraparte: contraparte,
        racaPadrao: racaPadrao,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PesagemScreen(loteId: id)),
      );
    }
  }
}
