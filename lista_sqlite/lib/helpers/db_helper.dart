import 'dart:async';
import 'dart:io' as io;

import 'package:lista_sqlite/helpers/produto.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TABLE = 'Produto';
  static const String DB_NAME = 'produto1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT)");
  }

  Future<Produto> save(Produto produto) async {
    var dbClient = await db;
    produto.id = await dbClient.insert(TABLE, produto.toMap());
    return produto;
  }

  Future<List<Produto>> getProdutos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Produto> produtos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        produtos.add(Produto.fromMap(maps[i]));
      }
    }
    return produtos;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Produto produto) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, produto.toMap(),
        where: '$ID = ?', whereArgs: [produto.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
