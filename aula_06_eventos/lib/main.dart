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