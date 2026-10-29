import 'package:sqflite/sqflite.dart';
import '../model/produto.dart';
import 'app_database.dart';


class ProdutoDAO {

  Future<Database> get _db async => await AppDatabase.instance.database;

  //CREATE
  Future<int> inserir(Produto produto) async {
    final db = await _db;
    return db.insert('produto', produto.toMap());
  }

  // READ
  Future<List<Produto>> listar() async {
    final db = await _db;
    final linhas = await db.query('produto', orderBy: 'nome ASC');
    return linhas.map(Produto.fromMap).toList();
  }


  // UPDATE
  Future<int> atualizar(Produto produto) async {
    final db = await _db;
    return db.update('produto', produto.toMap(), where: 'id = ?', whereArgs: [produto.id]);
  }


  // DELETE
  Future<int> deletar(int id) async {
    final db = await _db;
    return db.delete('produto', where: 'id = ?', whereArgs: [id]);
  }
  

}