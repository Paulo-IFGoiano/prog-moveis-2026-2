// MICRO-EXEMPLO — Ciclo 3: Form com um campo
// Aula 6 · O menor Form possível: uma chave, um campo, um botão.
//
// Faça ISTO primeiro, junto com o professor. Toque em Enviar com o campo
// vazio e veja a mensagem aparecer. Preencha e veja passar.
// Cole no dartpad.dev (modo Flutter) e rode.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Exemplo()));

class Exemplo extends StatefulWidget {
  const Exemplo({super.key});
  @override
  State<Exemplo> createState() => _ExemploState();
}

class _ExemploState extends State<Exemplo> {
  final _formKey = GlobalKey<FormState>();     // 1. a "chave" que comanda o Form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,                         // 2. o Form usa a chave
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Área (ha)'),
                validator: (valor) {             // 3. a regra do campo
                  if (valor == null || valor.isEmpty) {
                    return 'Informe a área';     //    devolve a mensagem...
                  }
                  return null;                   //    ...ou null se estiver ok
                },
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {  // 4. checa TODOS os campos
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Válido!')),
                    );
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// As quatro peças: a chave (1), o Form que a usa (2), o validator de cada
// campo que devolve mensagem-ou-null (3), e o validate() que dispara tudo
// de uma vez (4).
// Com um campo parece trabalho igual ao Ciclo 2. A vantagem aparece com
// VÁRIOS campos: é só acrescentar mais TextFormField, cada um com seu
// validator, e o mesmo validate() cuida de todos. É o que a atividade pede.
