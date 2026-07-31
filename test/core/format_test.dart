import 'package:flutter_test/flutter_test.dart';
import 'package:probov/core/format.dart';

void main() {
  test('formata centavos como reais', () {
    expect(formatBrl(532480), r'R$ 5.324,80');
    expect(formatBrl(0), r'R$ 0,00');
  });

  test('formata gramas como kg com uma casa', () {
    expect(formatKg(480500), '480,5 kg');
    expect(formatKg(1250000), '1.250,0 kg');
  });

  test('formata arrobas em centesimos', () {
    expect(formatArrobas(1664), '16,64 @');
  });

  test('formata basis points como percentual', () {
    expect(formatPercentBp(5200), '52,0%');
    expect(formatPercentBp(10000), '100,0%');
  });

  test('formata data no padrao brasileiro', () {
    expect(formatData(DateTime(2026, 7, 31)), '31/07/2026');
  });
}
