import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlManager {
  static const _VERSION = 3;
  static const _NAME = "mvc.db";
  static Database? _database;

  static Future<Database> init({String? sql}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _NAME);
    return await openDatabase(path,
        version: _VERSION,
        onCreate: (Database db, int version) async {},
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          var batch = db.batch();
          //执行升级部分
        });
  }

  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database!.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  static Future<Database?> getCurrentDatabase() async {
    if (_database != null) return _database!;

    _database = await init();

    // if(_database == null){
    //   await init();
    // }
    return _database;
  }

  static close() {
    _database?.close();
    _database = null;
  }
}

abstract class BaseDbProvider {
  bool isTableExits = false;

  createTableString();

  tableName();

  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database? db = await SqlManager.getCurrentDatabase();
      return await db!.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }
}
