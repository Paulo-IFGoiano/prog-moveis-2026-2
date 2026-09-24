// CICLO 2 — VALIDAÇÃO EM TEMPO REAL
// Aula 6 — Tratamento de eventos · IF Goiano — Campus Ceres
//
// PONTO DE PARTIDA
// Na calculadora, a validação acontecia SÓ quando você tocava em Calcular:
// o tryParse verificava tudo de uma vez. Funciona, mas o usuário só
// descobre o erro depois de tentar.
//
// A IDEIA DESTE CICLO
// Usar o evento onChanged para validar ENQUANTO o usuário digita, dando
// feedback imediato. É a diferença entre "você errou" (depois) e "cuidado
// com isso" (agora).
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
      home: const TelaCiclo2(),
    );
  }
}

class TelaCiclo2 extends StatefulWidget {
  const TelaCiclo2({super.key});

  @override
  State<TelaCiclo2> createState() => _TelaCiclo2State();
}

class _TelaCiclo2State extends State<TelaCiclo2> {
  // Mensagem de erro do campo de área. Nula = sem erro.
  String? _erroArea, _erroCotacao;

  // Valida a área conforme o usuário digita.
  void _validarArea(String texto) {
    final area = double.tryParse(texto.replaceAll(',', '.'));
    setState(() {
      if (texto.isEmpty) {
        _erroArea = null; // vazio ainda não é erro; é "não começou"
      } else if (area == null) {
        _erroArea = 'Digite um número válido';
      } else if (area <= 0) {
        _erroArea = 'A área deve ser maior que zero';
      } else if (area > 10000) {
        _erroArea = 'Área muito alta — confira se não há erro de digitação';
      } else {
        _erroArea = null; // tudo certo
      }
    });
  }

  void _validarCotacao(String texto) {
    final cotacao = double.tryParse(texto.replaceAll(',', '.'));
    setState(() {
      if (texto.isEmpty) {
        _erroCotacao = null; // vazio ainda não é erro; é "não começou"
      } else if (cotacao == null) {
        _erroCotacao = 'Digite um número válido';
      } else if (cotacao <= 0) {
        _erroCotacao = 'A cotação deve ser maior que zero';
      } else {
        _erroCotacao = null; // tudo certo
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo 2 — Validação'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Área do talhão (ha)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // passamos a mensagem de erro para o próprio campo,
            // via errorText. O Flutter mostra a mensagem em vermelho embaixo
            // do campo automaticamente.
            TextField(
              onChanged: _validarArea,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Ex.: 42,5',
                border: const OutlineInputBorder(),
                errorText: _erroArea, // <- feedback em tempo real
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cotação da saca',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 12),

            TextField(
              onChanged: _validarCotacao,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Ex.: 42,5',
                border: const OutlineInputBorder(),
                errorText: _erroCotacao, // <- feedback em tempo real
              ),
            ),



            const SizedBox(height: 16),

            // Indicador visual de "campo válido".
            if (_erroArea == null)
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF1E8449), size: 20),
                  SizedBox(width: 8),
                  Text('Campo pronto'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 — Rode e digite na área: letras, zero, um número enorme, um
//            número normal. Veja a mensagem em vermelho aparecer e sumir
//            embaixo do campo, sem precisar de botão.
//
// TAREFA 2 — Acrescente um segundo campo, para a cotação da saca, com sua
//            própria validação em tempo real (não pode ser vazio nem
//            negativo). Crie _erroCotacao e _validarCotacao seguindo o
//            mesmo padrão.
//
// TAREFA 3 — Faça o ícone de "Campo pronto" só aparecer quando OS DOIS
//            campos estiverem válidos e preenchidos.
//
// TAREFA 4 — Reflita em comentário: qual a vantagem de validar durante a
//            digitação em vez de só no botão? E existe alguma desvantagem?
