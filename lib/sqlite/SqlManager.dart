import 'package:flutter/material.dart';
import 'package:mvcwallet/sqlite/SqWallet.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlManager {
  static int _VERSION = 2;
  static const _NAME = "mvc.db";
  static Database? _database;
  static bool isSuccessUpdateVersion = false;
  static String isUpdateVersion = "isUpdateVersion_key";

  static Future<Database> init({String? sql}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _NAME);
    return await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {},
        onUpgrade: _onUpgrade);

    // return await openDatabase(path,
    //     version: _VERSION, onCreate: (Database db, int version) async {},
    //     onUpgrade: (Database db, int oldVersion, int newVersion) async {
    //       var batch = db.batch();
    //       //执行升级部分
    //     });
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

    SharedPreferencesUtils.getBool(isUpdateVersion).then((value) {
     isSuccessUpdateVersion=value;
     print("保存的是否升级："+isSuccessUpdateVersion.toString());

     // if(isSuccessUpdateVersion==false){
     //   _database!.database!.setVersion(1);
     // }


    });



    // _database!.database!.setVersion(1);
    _database!.database!.getVersion().then((value) =>
        print("当前：" + value.toString()));

    // if(_database == null){
    //   await init();
    // }
    return _database;
  }

  static close() {
    _database?.close();
    _database = null;
  }

  static void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      var batch = db.batch();
      print("进入数据库升级模块");
      if (oldVersion == 1) {
        _updateTableV1ToV2(batch);
      }
      print("新的版本是：$newVersion");
      await db.setVersion(newVersion);
      await batch.commit();
      print("升级完成 当前的版本是:${db.getVersion()}");
      db.getVersion().then((value) =>
          print("升级完成 当前的版本是：" + value.toString()));
      SharedPreferencesUtils.setBool(isUpdateVersion, true);
    } catch (e) {
      print("升级失败$e");
      db.setVersion(oldVersion);
      await db.setVersion(oldVersion);
      db.getVersion().then((value) => print("失败的版本是：${value.toString()}"));
      SharedPreferencesUtils.setBool(isUpdateVersion, false);
      // print("升级失败后的版本是： ${}");
    }
  }

  static void _updateTableV1ToV2(Batch batch) {
    print("升级字段升级中");
    batch.execute("alter table ${SqWallet.simName} add column ${SqWallet.btcAddress} TEXT NOT NULL default \"\"");
    batch.execute("alter table ${SqWallet.simName} add column ${SqWallet.btcPath} TEXT NOT NULL default \"\"");
    batch.execute("alter table ${SqWallet.simName} add column ${SqWallet.btcBalance} TEXT NOT NULL default \"\"");
    // batch.execute("alter table ${SqWallet.simName} add column ${SqWallet
    //     .btcBalance} TEXT NOT NULL");
  }
}

//////////////////////////////////////////

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
