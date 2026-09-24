// MICRO-EXEMPLO — Ciclo 1: onChanged
// Aula 6 · O menor exemplo possível de reagir à digitação.
//
// Faça ISTO primeiro, junto com o professor, antes da atividade.
// É de propósito minúsculo: um campo, um texto que reage. Só isso.
// Cole no dartpad.dev (modo Flutter), rode e digite no campo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Exemplo()));

class Exemplo extends StatefulWidget {
  const Exemplo({super.key});
  @override
  State<Exemplo> createState() => _ExemploState();
}

class _ExemploState extends State<Exemplo> {
  String _nome = '';                       // 1. o estado: o que foi digitado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (texto) {          // 2. dispara a CADA tecla
                setState(() {               // 3. avisa a tela que mudou
                  _nome = texto;
                });
              },
              decoration: const InputDecoration(labelText: 'Seu nome'),
            ),
            const SizedBox(height: 16),
            Text('Olá, $_nome'),            // 4. muda sozinho ao digitar
          ],
        ),
      ),
    );
  }
}

// A ideia inteira em quatro linhas numeradas acima:
//   guardo o texto (1), reajo a cada tecla (2), aviso a tela (3),
//   e a tela mostra o novo valor (4).
// A atividade do Ciclo 1 é este mesmo esqueleto, com mais coisas em volta.
