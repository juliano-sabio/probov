import 'package:intl/intl.dart';

final _n2 = NumberFormat('#,##0.00', 'pt_BR');
final _n1 = NumberFormat('#,##0.0', 'pt_BR');
final _data = DateFormat('dd/MM/yyyy');

/// O símbolo de moeda é concatenado à mão em vez de usar
/// `NumberFormat.currency`, porque o padrão pt_BR do ICU usa espaço
/// não separável entre `R$` e o número — invisível na tela e causa de teste
/// que falha por um caractere que ninguém vê.
String formatBrl(int centavos) => 'R\$ ${_n2.format(centavos / 100)}';

String formatKg(int pesoG) => '${_n1.format(pesoG / gramasPorKgDouble)} kg';

/// Recebe arrobas em centésimos: 1664 é 16,64 arrobas.
String formatArrobas(int centesimos) => '${_n2.format(centesimos / 100)} @';

String formatPercentBp(int bp) => '${_n1.format(bp / 100)}%';

String formatData(DateTime d) => _data.format(d);

/// Só para conversão de exibição. O cálculo nunca usa double.
const double gramasPorKgDouble = 1000.0;

/// Centavos para texto editável: 32000 vira `'320,00'`.
/// Sem separador de milhar, porque o usuário está digitando.
String formatCentavosParaCampo(int centavos) =>
    '${centavos ~/ 100},${(centavos % 100).toString().padLeft(2, '0')}';

/// Basis points para texto editável de percentual: 5200 vira `'52,00'`.
String formatBpParaCampo(int bp) => formatCentavosParaCampo(bp);

/// Gramas para texto editável de kg: 480500 vira `'480,5'`.
String formatPesoParaCampo(int pesoG) {
  final kg = pesoG ~/ 1000;
  final g = pesoG % 1000;
  if (g == 0) return '$kg';
  return '$kg,${g.toString().padLeft(3, '0').replaceAll(RegExp(r'0+$'), '')}';
}
