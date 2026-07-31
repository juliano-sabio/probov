import 'package:flutter_test/flutter_test.dart';
import 'package:probov/core/parse.dart';

void main() {
  group('parsePesoG', () {
    test('inteiro vira gramas', () => expect(parsePesoG('480'), 480000));
    test('uma casa decimal', () => expect(parsePesoG('480,5'), 480500));
    test('virgula solta no fim', () => expect(parsePesoG('480,'), 480000));
    test('texto vazio e nulo', () => expect(parsePesoG(''), isNull));
    test('texto invalido e nulo', () => expect(parsePesoG('abc'), isNull));
    test('mais casas que a escala e nulo',
        () => expect(parsePesoG('1,2345'), isNull));
  });

  group('parseCentavos', () {
    test('inteiro vira centavos', () => expect(parseCentavos('320'), 32000));
    test('duas casas', () => expect(parseCentavos('320,50'), 32050));
    test('uma casa completa com zero',
        () => expect(parseCentavos('12,5'), 1250));
    test('separador de milhar e ignorado',
        () => expect(parseCentavos('1.320,00'), 132000));
    test('texto vazio e nulo', () => expect(parseCentavos(''), isNull));
  });
}
