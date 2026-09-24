// MICRO-EXEMPLO — Ciclo 4: GestureDetector
// Aula 6 · O menor exemplo de captar gestos numa caixa qualquer.
//
// Faça ISTO primeiro, junto com o professor. Toque na caixa e segure a
// caixa: cada gesto muda a mensagem. Um widget, dois gestos.
// Cole no dartpad.dev (modo Flutter) e rode.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Exemplo()));

class Exemplo extends StatefulWidget {
  const Exemplo({super.key});
  @override
  State<Exemplo> createState() => _ExemploState();
}

class _ExemploState extends State<Exemplo> {
  String _ultimo = 'Nenhum gesto ainda';      // 1. o estado: o último gesto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(                 // 2. envolve o que vai reagir
          onTap: () {                           // 3. toque simples
            setState(() => _ultimo = 'Toque simples');
          },
          onLongPress: () {                     // 4. segurar
            setState(() => _ultimo = 'Toque longo');
          },
          child: Container(                     // 5. o widget que recebe o gesto
            padding: const EdgeInsets.all(40),
            color: const Color(0xFFD5F5E3),
            child: Text(_ultimo),
          ),
        ),
      ),
    );
  }
}

// O GestureDetector (2) não desenha nada: ele só ESCUTA gestos e roda a
// função certa — onTap para toque (3), onLongPress para segurar (4). Quem
// aparece na tela é o child (5). Trocar o estado dentro de setState faz a
// mensagem mudar.
// A atividade do Ciclo 4 usa isto em cada cartão de talhão, com onTap para
// selecionar e onLongPress para uma ação rápida.
//
// Detalhe: o GestureDetector não faz o efeito visual de "splash" ao tocar.
// Quando quiser esse brilho de Material, troque por InkWell — mesma ideia
// de onTap/onLongPress.
