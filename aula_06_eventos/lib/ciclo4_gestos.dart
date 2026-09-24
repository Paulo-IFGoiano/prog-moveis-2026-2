// CICLO 4 — GESTOS: ALÉM DO TOQUE SIMPLES
// Aula 6 — Tratamento de eventos · IF Goiano — Campus Ceres
//
// A IDEIA
// Até aqui os eventos vieram de widgets prontos (botões, campos). Mas
// qualquer parte da tela pode responder a gestos, envolvendo-a em um
// GestureDetector. Ele capta toque simples, toque longo, duplo toque e
// arrastar — os gestos que um app de campo usa o tempo todo.
//
// O CENÁRIO
// Um cartão de talhão que responde a gestos: toque simples seleciona,
// toque longo abre uma ação rápida (como marcar atividade).
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
      home: const TelaCiclo4(),
    );
  }
}

class TelaCiclo4 extends StatefulWidget {
  const TelaCiclo4({super.key});

  @override
  State<TelaCiclo4> createState() => _TelaCiclo4State();
}

class _TelaCiclo4State extends State<TelaCiclo4> {
  final _talhoes = ['Talhão 1 — soja', 'Talhão 2 — milho', 'Talhão 3 — sorgo'];
  int? _selecionado; // índice do talhão selecionado; nulo = nenhum

  void _abrirAcaoRapida(String talhao) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(talhao),
        content: const Text('Ação rápida: registrar atividade agora?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo 4 — Gestos'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _talhoes.length,
        itemBuilder: (context, indice) {
          final selecionado = _selecionado == indice;
          // GestureDetector envolve o cartão e capta os gestos.
          return GestureDetector(
            // Toque simples: seleciona/desseleciona.
            onTap: () {
              setState(() {
                _selecionado = selecionado ? null : indice;
              });
            },
            // Toque longo: abre a ação rápida.
            onLongPress: () => _abrirAcaoRapida(_talhoes[indice]),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: selecionado
                    ? const Color(0xFFD5F5E3)
                    : Colors.white,
                border: Border.all(
                  color: selecionado
                      ? const Color(0xFF1E8449)
                      : const Color(0xFFE0E0E0),
                  width: selecionado ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    selecionado ? Icons.check_circle : Icons.grass,
                    color: const Color(0xFF1E5631),
                  ),
                  const SizedBox(width: 12),
                  Text(_talhoes[indice],
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          _selecionado == null
              ? 'Toque para selecionar · segure para ação rápida'
              : 'Selecionado: ${_talhoes[_selecionado!]}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 — Rode. Toque num cartão (seleciona) e segure num cartão
//            (abre o diálogo de ação rápida). Dois gestos, um widget.
//
// TAREFA 2 — Adicione onDoubleTap ao GestureDetector para mostrar um
//            SnackBar com o nome do talhão. Teste os três gestos no mesmo
//            cartão.
//
// TAREFA 3 — Faça o cartão selecionado exibir um botão "Registrar
//            atividade" abaixo do nome, que só aparece quando ele está
//            selecionado. Dica: um if dentro da Column.
//
// TAREFA 4 — DESAFIO: junte tudo o que viu na aula. Crie uma tela de
//            registro de atividade com: um Form (Ciclo 3) para os dados,
//            validação em tempo real no campo de observação (Ciclos 1 e 2)
//            e um cartão de resumo que responde a toque longo (Ciclo 4).
