import 'package:flutter/material.dart';

/// Teclado numérico grande. Teclas de 64 px de altura mínima porque a tela é
/// usada em pé, no sol, muitas vezes de luva.
class Keypad extends StatelessWidget {
  final ValueChanged<String> onTecla;
  final VoidCallback onApagar;

  const Keypad({super.key, required this.onTecla, required this.onApagar});

  @override
  Widget build(BuildContext context) {
    final linhas = [
      ['7', '8', '9'],
      ['4', '5', '6'],
      ['1', '2', '3'],
      [',', '0', 'apagar'],
    ];

    return Column(
      children: linhas
          .map((linha) => Row(
                children: linha
                    .map((t) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: SizedBox(
                              height: 64,
                              child: t == 'apagar'
                                  ? OutlinedButton(
                                      onPressed: onApagar,
                                      child:
                                          const Icon(Icons.backspace_outlined),
                                    )
                                  : OutlinedButton(
                                      onPressed: () => onTecla(t),
                                      child: Text(
                                        t,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                            ),
                          ),
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}
