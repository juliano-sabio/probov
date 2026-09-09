import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/lotes/lotes_screen.dart';

/// Verde de pasto. Mais fechado que o verde-material padrão de propósito: o app
/// é usado no curral, sob sol direto, e tom claro demais some na tela.
const _verdePasto = Color(0xFF1B5E20);

/// Todo número do app é alinhado em coluna. Sem isto o "1" ocupa menos largura
/// que o "8", e uma lista de pesos fica com a vírgula dançando linha a linha.
const _numerosAlinhados = [FontFeature.tabularFigures()];

class ProbovApp extends StatelessWidget {
  const ProbovApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Probov',
      debugShowCheckedModeBanner: false,
      // Sem isto o seletor de data aparece em inglês.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
      theme: _tema(),
      home: const LotesScreen(),
    );
  }
}

ThemeData _tema() {
  final esquema =
      ColorScheme.fromSeed(
        seedColor: _verdePasto,
        // O M3 tinge a superfície com a semente e o fundo sai esverdeado e
        // lavado. No sol isso reduz contraste, então a superfície é neutra.
        surface: const Color(0xFFFCFCFA),
      ).copyWith(
        surfaceContainerHighest: const Color(0xFFEFEFEA),
        outlineVariant: const Color(0xFFD5D7D0),
      );

  // Inter no lugar da fonte do sistema: altura-x maior, então o número lido de
  // relance a um metro da balança fica mais legível que na Roboto.
  final base = ThemeData(
    colorScheme: esquema,
    useMaterial3: true,
    fontFamily: 'Inter',
  );

  return base.copyWith(
    scaffoldBackgroundColor: esquema.surface,
    textTheme: _alinharNumeros(base.textTheme),

    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: esquema.outlineVariant),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: esquema.surface,
      foregroundColor: esquema.onSurface,
      // Sem sombra, mas com uma linha: separa o cabeçalho do conteúdo sem
      // escurecer a tela.
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: Border(bottom: BorderSide(color: esquema.outlineVariant)),
      titleTextStyle: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
    ),

    // Alvo de toque maior: o app é operado em pé, no curral, muitas vezes de luva.
    listTileTheme: const ListTileThemeData(
      minVerticalPadding: 14,
      horizontalTitleGap: 14,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    ),

    dividerTheme: DividerThemeData(
      color: esquema.outlineVariant,
      space: 1,
      thickness: 1,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: esquema.primary,
      foregroundColor: esquema.onPrimary,
      extendedTextStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 52),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 52),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: esquema.surfaceContainerHighest.withValues(alpha: 0.5),
    ),

    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(minimumSize: const Size(0, 48)),
    ),
  );
}

TextTheme _alinharNumeros(TextTheme t) {
  TextStyle? n(TextStyle? s) => s?.copyWith(fontFeatures: _numerosAlinhados);

  /// Título: números alinhados mais tracking apertado. A Inter é larga, e sem
  /// isto o título fica com ar solto que a Roboto não tinha.
  TextStyle? g(TextStyle? s, double tracking) =>
      n(s)?.copyWith(letterSpacing: tracking, fontWeight: FontWeight.w700);

  return t.copyWith(
    displayLarge: g(t.displayLarge, -1.6),
    displayMedium: g(t.displayMedium, -1.2),
    displaySmall: g(t.displaySmall, -1.0),
    headlineLarge: g(t.headlineLarge, -0.8),
    headlineMedium: g(t.headlineMedium, -0.6),
    headlineSmall: g(t.headlineSmall, -0.4),
    titleLarge: g(t.titleLarge, -0.3),
    titleMedium: n(t.titleMedium),
    titleSmall: n(t.titleSmall),
    bodyLarge: n(t.bodyLarge),
    bodyMedium: n(t.bodyMedium),
    bodySmall: n(t.bodySmall),
    labelLarge: n(t.labelLarge),
    labelMedium: n(t.labelMedium),
  );
}
