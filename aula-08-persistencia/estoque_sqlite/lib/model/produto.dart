class Produto {
  final int? id;
  final String nome;
  final int quantidade;
  final double preco;

  const Produto({
    this.id,
    required this.nome,
    required this.quantidade,
    required this.preco,
  });

  Map<String, Object?> toMap() {
    return{
      if(id != null) 'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'preco': preco,
    };
  }

  factory Produto.fromMap(Map<String, Object?> map) {
    return Produto(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      quantidade: map['quantidade'] as int,
      preco: (map['preco'] as num).toDouble(),
    );
  }

}