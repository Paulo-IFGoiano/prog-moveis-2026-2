// ============================================================
// CAMADA DE DADOS: AppDatabase  (camada data)
// Único lugar que "conhece" o arquivo .db: abre o banco e cria a
// tabela. Os DAOs pedem a conexão a ela.
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
        await db.execute('''
          CREATE TABLE produto (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            nome        TEXT NOT NULL,
            quantidade  INTEGER NOT NULL,
            preco       REAL NOT NULL
          )
        ''');
      },
    );
  }
}
