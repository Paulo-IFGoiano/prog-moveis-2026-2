// ============================================================
// CAMADA DE DADOS: AppDatabase  (PROJETO-INICIAL)
// Abre o banco e cria a tabela.
//
// >>> SUA TAREFA (Passo 4): escrever o CREATE TABLE no onCreate.
//     O resto (abrir o banco) já está pronto.
// ============================================================

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _abrir();
    return _db!;
  }

  Future<Database> _abrir() async {
    final dir = await getDatabasesPath();
    final caminho = p.join(dir, 'estoque.db');
    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) async {
        // ===== PASSO 4: crie a tabela "produto" =====
        // Colunas: id (PK AUTOINCREMENT), nome (TEXT NOT NULL),
        //          quantidade (INTEGER NOT NULL), preco (REAL NOT NULL).
        //
        // await db.execute('''
        //   CREATE TABLE produto (
        //     ...
        //   )
        // ''');
      },
    );
  }
}
