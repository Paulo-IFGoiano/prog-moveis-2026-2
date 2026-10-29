import '../data/produto_dao.dart';
import '../model/produto.dart';

class ProdutoRepository {
  final ProdutoDAO _dao = ProdutoDAO();

  //listar
  Future<List<Produto>> listar() => _dao.listar();


  //salvar
  Future<void> salvar(Produto produto) async {
    if (produto.id == null) {
      await _dao.inserir(produto);
    } else {
      await _dao.atualizar(produto);
    }
  }

  //deletar
  Future<void> remover(int id) => _dao.deletar(id);
}