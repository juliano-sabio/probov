import 'package:flutter_test/flutter_test.dart';
import 'package:probov/core/units.dart';

void main() {
  group('divArredondado', () {
    test('arredonda para baixo abaixo da metade', () {
      expect(divArredondado(1004, 10), 100);
    });

    test('arredonda para cima na metade exata', () {
      expect(divArredondado(1005, 10), 101);
    });

    test('divisao exata nao muda', () {
      expect(divArredondado(1000, 10), 100);
    });
  });

  test('constantes de unidade', () {
    expect(gramasPorKg, 1000);
    expect(bpTotal, 10000);
    expect(kgPorArroba, 15);
  });
}
