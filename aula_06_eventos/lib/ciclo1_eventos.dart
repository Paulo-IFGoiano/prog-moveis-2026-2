// CICLO 1 — O QUE É UM EVENTO  ·  onPressed e onChanged
// Aula 6 — Tratamento de eventos · IF Goiano — Campus Ceres
//
// PONTO DE PARTIDA
// Na calculadora, você já usou onPressed: "quando o botão for tocado,
// execute esta função". Isso é um evento. Hoje vamos entender o conceito
// e conhecer outros eventos além do toque no botão.
//
// A IDEIA DESTE CICLO
// onChanged dispara a CADA tecla digitada, não só no final. Isso permite
// reagir enquanto o usuário digita — por exemplo, mostrar na hora quantos
// caracteres faltam, ou calcular sem precisar de botão.
//
// Cole no dartpad.dev (modo Flutter), rode e siga as tarefas.

import 'package:flutter/material.dart';

void main() => runApp(const AppEventos());

class AppEventos extends StatelessWidget {
  const AppEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5631)),
        useMaterial3: true,
      ),
      home: const TelaCiclo1(),
    );
  }
}

class TelaCiclo1 extends StatefulWidget {
  const TelaCiclo1({super.key});

  @override
  State<TelaCiclo1> createState() => _TelaCiclo1State();
}

class _TelaCiclo1State extends State<TelaCiclo1> {
  // Guarda o que foi digitado no campo de observação do talhão.
  String _observacao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo 1 — Eventos'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Observação da atividade no talhão',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // onChanged: dispara a CADA tecla. A função recebe o texto
            // atual do campo e nós guardamos no estado.
            TextField(
              onChanged: (texto) {
                setState(() {
                  _observacao = texto;
                });
              },
              maxLength: 80,
              decoration: const InputDecoration(
                labelText: 'Ex.: pulverização feita pela manhã',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Este texto se atualiza SOZINHO enquanto você digita, porque
            // o onChanged chama setState a cada tecla.
            Text('Você escreveu: $_observacao'),
            const SizedBox(height: 8),
            Text('Caracteres: ${_observacao.length} de 80'),
          ],
        ),
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 — Rode e digite no campo. Observe que o texto "Você escreveu"
//            muda a cada letra, sem você tocar em nenhum botão. Esse é o
//            evento onChanged em ação.
//
// TAREFA 2 — Faça o contador de caracteres ficar VERMELHO quando passar de
//            60. Dica: um TextStyle com color condicional —
//            style: TextStyle(color: _observacao.length > 60 ? Colors.red : Colors.black)
//
// TAREFA 3 — Adicione um segundo texto que mostre a observação em letras
//            MAIÚSCULAS, atualizando junto. Dica: _observacao.toUpperCase().
//
// TAREFA 4 — Explique em comentário, com suas palavras, a diferença entre
//            onPressed (que você usou na calculadora) e onChanged (deste
//            ciclo). Quando usar cada um?
