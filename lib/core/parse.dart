/// Converte texto digitado em inteiro escalado, sem passar por `double`.
///
/// `casas` é o número de decimais da escala de destino: 2 para centavos,
/// 3 para gramas. O parse é feito por string justamente para não introduzir
/// erro de ponto flutuante na entrada — `12,5` precisa virar exatamente 1250.
///
/// Retorna `null` se o texto não for um número válido na escala.
int? parseEscalado(String texto, int casas) {
  final t = texto.trim().replaceAll('.', '').replaceAll(' ', '');
  if (t.isEmpty) return null;

  final partes = t.split(',');
  if (partes.length > 2) return null;

  final inteiro = partes[0].isEmpty ? '0' : partes[0];
  final frac = partes.length == 2 ? partes[1] : '';
  if (frac.length > casas) return null;

  final i = int.tryParse(inteiro);
  final f = int.tryParse(frac.padRight(casas, '0'));
  if (i == null || f == null) return null;

  var escala = 1;
  for (var k = 0; k < casas; k++) {
    escala *= 10;
  }
  return i * escala + f;
}

/// `'480,5'` vira 480500 gramas.
int? parsePesoG(String texto) => parseEscalado(texto, 3);

/// `'320,50'` vira 32050 centavos.
int? parseCentavos(String texto) => parseEscalado(texto, 2);
