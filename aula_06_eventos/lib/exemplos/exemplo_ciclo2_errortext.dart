// MICRO-EXEMPLO — Ciclo 2: validação em tempo real com errorText
// Aula 6 · O menor exemplo de mostrar erro enquanto se digita.
//
// Faça ISTO primeiro, junto com o professor. Um campo só. A mensagem
// vermelha aparece e some sozinha conforme o que você digita.
// Cole no dartpad.dev (modo Flutter), rode e teste: digite letras, um
// número negativo, e um número normal.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Exemplo()));

class Exemplo extends StatefulWidget {
  const Exemplo({super.key});
  @override
  State<Exemplo> createState() => _ExemploState();
}

class _ExemploState extends State<Exemplo> {
  String? _erro;                              // 1. a mensagem de erro (ou nula)

  void _validar(String texto) {               // 2. roda a cada tecla
    final n = double.tryParse(texto);         //    tenta virar número
    setState(() {
      if (texto.isEmpty)     _erro = null;    //    vazio: ainda não é erro
      else if (n == null)    _erro = 'Digite um número';
      else if (n <= 0)       _erro = 'Precisa ser maior que zero';
      else                   _erro = null;    //    tudo certo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: _validar,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Área (ha)',
                errorText: _erro,             // 3. o campo mostra o erro sozinho
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// O truque está no errorText (3): você só entrega a mensagem, e o próprio
// TextField desenha ela em vermelho embaixo. Você não precisa criar nenhum
// widget de erro à mão.
// A atividade do Ciclo 2 é este padrão, com um segundo campo e um indicador
// de "tudo pronto".
