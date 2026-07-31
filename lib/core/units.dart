/// Constantes de unidade do domínio. Todo número de negócio no app é inteiro:
/// peso em gramas, dinheiro em centavos, percentual em basis points.
const int gramasPorKg = 1000;
const int bpTotal = 10000;
const int kgPorArroba = 15;

/// Divisão inteira arredondando para o mais próximo, metade para cima.
///
/// Só é correta para numerador e denominador positivos, que é o caso em todo o
/// app — não existe peso nem preço negativo. Truncar (`~/`) em vez de arredondar
/// perderia um centavo por animal, e num lote de 200 cabeças isso aparece no total.
int divArredondado(int numerador, int denominador) =>
    (numerador + denominador ~/ 2) ~/ denominador;
