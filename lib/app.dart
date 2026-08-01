import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/lotes/lotes_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const LotesScreen(),
    );
  }
}
