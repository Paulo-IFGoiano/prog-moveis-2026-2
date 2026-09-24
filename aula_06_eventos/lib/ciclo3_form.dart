// CICLO 3 — VALIDAÇÃO ESTRUTURADA COM Form
// Aula 6 — Tratamento de eventos · IF Goiano — Campus Ceres
//
// O PROBLEMA QUE ISSO RESOLVE
// No ciclo anterior, cada campo tinha seu próprio _erro e sua própria
// função de validação. Com muitos campos, isso vira muito código repetido.
// O Flutter oferece uma forma organizada: Form + TextFormField + validator.
//
// COMO FUNCIONA
// - Form agrupa vários campos e tem uma "chave" (GlobalKey) para comandá-los.
// - Cada TextFormField traz seu próprio validator: uma função que devolve
//   a mensagem de erro (ou null se estiver tudo certo).
// - _formKey.currentState!.validate() dispara TODAS as validações de uma vez
//   e devolve true se todos os campos estiverem válidos.
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
      home: const TelaCiclo3(),
    );
  }
}

class TelaCiclo3 extends StatefulWidget {
  const TelaCiclo3({super.key});

  @override
  State<TelaCiclo3> createState() => _TelaCiclo3State();
}

class _TelaCiclo3State extends State<TelaCiclo3> {
  // A chave que dá acesso ao estado do formulário.
  final _formKey = GlobalKey<FormState>();
  final _areaController = TextEditingController();
  final _produtividadeController = TextEditingController();

  @override
  void dispose() {
    _areaController.dispose();
    _produtividadeController.dispose();
    super.dispose();
  }

  // Um validator reutilizável para números positivos.
  String? _validarPositivo(String? valor, String nomeCampo) {
    if (valor == null || valor.isEmpty) {
      return 'Informe $nomeCampo';
    }
    final numero = double.tryParse(valor.replaceAll(',', '.'));
    if (numero == null) {
      return '$nomeCampo deve ser um número';
    }
    if (numero <= 0) {
      return '$nomeCampo deve ser maior que zero';
    }
    return null; // válido
  }

  void _enviar() {
    // Dispara todos os validators de uma vez.
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados válidos! Registro salvo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo 3 — Form'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _areaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Área do talhão (ha)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _validarPositivo(v, 'a área'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _produtividadeController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Produtividade (sacas/ha)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _validarPositivo(v, 'a produtividade'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _enviar,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5631),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 — Rode e toque em Registrar com os campos vazios. As duas
//            mensagens aparecem de uma vez. Preencha corretamente e veja
//            o SnackBar de sucesso.
//
// TAREFA 2 — Adicione um terceiro campo: cotação da saca (R$), com o mesmo
//            validator reutilizável. Repare como é pouco código a mais —
//            essa é a vantagem do Form sobre o ciclo anterior.
//
// TAREFA 3 — Crie um validator específico para a área que também rejeite
//            valores acima de 10.000 ha (erro de digitação provável).
//
// TAREFA 4 — Compare com o Ciclo 2. Em comentário: quando vale usar
//            validação em tempo real (onChanged) e quando vale a validação
//            no envio (Form + validate)? Dá para combinar as duas?
