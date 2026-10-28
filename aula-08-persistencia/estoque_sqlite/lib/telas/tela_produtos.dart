// ============================================================
// UI: TelaProdutos  (camada telas)
// Lista os produtos (via Repository) e permite adicionar,
// editar e remover. A tela NÃO conhece SQL nem o DAO.
// ============================================================

import 'package:flutter/material.dart';
import '../model/produto.dart';
import '../repository/produto_repository.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  final _repo = ProdutoRepository();
  late Future<List<Produto>> _futuro;

  @override
  void initState() {
    super.initState();
    _recarregar();
  }

  // Refaz a consulta ao banco e redesenha a tela.
  void _recarregar() {
    setState(() {
      _futuro = _repo.listar();
    });
  }

  Future<void> _abrirForm({Produto? existente}) async {
    final salvou = await showDialog<bool>(
      context: context,
      builder: (_) => _FormProduto(repo: _repo, existente: existente),
    );
    if (salvou == true) _recarregar();
  }

  Future<void> _remover(Produto p) async {
    await _repo.remover(p.id!);
    _recarregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque de Insumos'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(),
        icon: const Icon(Icons.add),
        label: const Text('Novo'),
      ),
      body: FutureBuilder<List<Produto>>(
        future: _futuro,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final produtos = snap.data ?? [];
          if (produtos.isEmpty) {
            return const Center(child: Text('Nenhum produto cadastrado.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: produtos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final p = produtos[i];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFD5F5E3),
                    child: Icon(Icons.inventory_2, color: Color(0xFF1E5631)),
                  ),
                  title: Text(p.nome,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    'Qtd: ${p.quantidade}  ·  '
                    'R\$ ${p.preco.toStringAsFixed(2)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _abrirForm(existente: p),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _remover(p),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ---- Formulário (em um diálogo) para criar/editar ----
class _FormProduto extends StatefulWidget {
  const _FormProduto({required this.repo, this.existente});
  final ProdutoRepository repo;
  final Produto? existente;

  @override
  State<_FormProduto> createState() => _FormProdutoState();
}

class _FormProdutoState extends State<_FormProduto> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nome;
  late final TextEditingController _qtd;
  late final TextEditingController _preco;

  @override
  void initState() {
    super.initState();
    final e = widget.existente;
    _nome = TextEditingController(text: e?.nome ?? '');
    _qtd = TextEditingController(text: e?.quantidade.toString() ?? '');
    _preco = TextEditingController(text: e?.preco.toString() ?? '');
  }

  @override
  void dispose() {
    _nome.dispose();
    _qtd.dispose();
    _preco.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    final produto = Produto(
      id: widget.existente?.id,
      nome: _nome.text.trim(),
      quantidade: int.parse(_qtd.text),
      preco: double.parse(_preco.text.replaceAll(',', '.')),
    );
    // O Repository decide se é inserir ou atualizar.
    await widget.repo.salvar(produto);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existente == null ? 'Novo produto' : 'Editar produto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nome,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
            ),
            TextFormField(
              controller: _qtd,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n < 0) return 'Quantidade inválida';
                return null;
              },
            ),
            TextFormField(
              controller: _preco,
              decoration: const InputDecoration(labelText: 'Preço (R\$)'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                if (n == null || n < 0) return 'Preço inválido';
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _salvar, child: const Text('Salvar')),
      ],
    );
  }
}
