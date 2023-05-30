import 'package:mvcwallet/sqlite/SqlManager.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:sqflite/sqflite.dart';

class SqWallet extends BaseDbProvider {
  //name
  String simName = "wallet";
  String id = "id";
  String name = "name";
  String mnemonic = "mnemonic";
  String path = "path";
  String address = "address";
  String balance = "balance";
  String isChoose="isChoose";

  SqWallet();

  @override
  tableName() {
    return simName;
  }

  @override
  createTableString() {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';

    // return "create table $simName($id text not null,$name text not null,$mnemonic text not null,$path text not null,$address text not null,$balance text not null)";
 /*   String sql = '''CREATE TABLE $simName(
       $id $integerType,  
       $name $textType,  
       $mnemonic $textType,  
       $path $integerType,  
       $address $textType,  
       $balance $doubleType )
    ''';*/
    String sql = '''CREATE TABLE $simName(
       $id $textType,  
       $name $textType,  
       $mnemonic $textType,  
       $path $textType,  
       $address $textType,  
       $isChoose $integerType,  
       $balance $textType )
    ''';
    return sql;
  }

  Future getWalletByID(Database db, String walletID) async {
    // List<Map<String, dynamic>> maps =
    //     await db.rawQuery("select * from $simName where $mnemonic = $walletID");
    List<Map<String, dynamic>> maps = await db.query(simName,where: "$mnemonic=?",whereArgs: [walletID]);
    return maps;
  }

  Future insert(Wallet wallet) async {
    Database db = await getDataBase();
    var walletProvider = await getWalletByID(db, wallet.mnemonic);
    if (walletProvider != null) {
      print("查询的数据："+walletProvider.toString());
      await db.delete(simName, where: "$mnemonic = ?", whereArgs: [wallet.mnemonic]);
    }
    print("插入的数据："+wallet.toString());
    return await db.rawInsert(
        "insert into $simName($id,$name,$mnemonic,$path,$address,$balance,$isChoose) values (?,?,?,?,?,?,?)",
        [
          wallet.id,
          wallet.name,
          wallet.mnemonic,
          wallet.path,
          wallet.address,
          wallet.balance,
          wallet.isChoose,
        ]);
  }

  Future<void> delete(Wallet wallet) async {
    Database db = await getDataBase();
    var walletProvider = await getWalletByID(db, wallet.mnemonic);
    if (walletProvider != null) {
      await db.delete(simName, where: '$mnemonic = ?', whereArgs: [wallet.mnemonic]);
    }
  }

  Future<void> update(Wallet wallet) async {
    Database database = await getDataBase();
    // await database.rawUpdate(
    //     "update $simName set $id = ?,$name = ?,$mnemonic = ?, $path = ?,$address = ?,$balance = ?",
    //     [
    //       wallet.id,
    //       wallet.name,
    //       wallet.mnemonic,
    //       wallet.path,
    //       wallet.address,
    //       wallet.balance
    //     ]);
    database.update(
      simName,
      wallet.toJson(),
      where: '$mnemonic = ?',
      whereArgs: [wallet.mnemonic],
    );
  }

  Future<Wallet?> getOneWallet(String id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await getWalletByID(db, id);
    if (maps.isNotEmpty) {
      return Wallet.fromJson(maps[0]);
    }
    return null;
  }

  Future<List<Wallet>> getAllWallet() async {
    Database db = await getDataBase();
    // var result= await db.rawQuery("select * from $simName");
    final result = await db.query(simName);
    return result.map((json) => Wallet.fromJson(json)).toList();
    // return result.toList();
  }


  Future<void> refreshDefaultData(bool isInset,Wallet sWallet) async{
    Future<List<Wallet>> list = getAllWallet();
    list.then((value) {
      if (value.isNotEmpty) {
        print("获取的缓存数据："+value.toString());
        for (var wallet in value) {
          // ignore: unrelated_type_equality_checks
          wallet.isChoose=0;
          update(wallet);
          if(isInset){
            if(sWallet.mnemonic==wallet.mnemonic){
              delete(wallet);
            }
          }
        }
      } else {
        print("Wallet Null");
      }
      if(isInset){
        insert(sWallet);
      }
    });
  }

  Future<void> updateDefaultData(Wallet sWallet) async{
    Future<List<Wallet>> list = getAllWallet();
    list.then((value) {
      if (value.isNotEmpty) {
        print("获取的缓存数据："+value.toString());
        for (var wallet in value) {
          // ignore: unrelated_type_equality_checks
          wallet.isChoose=0;
          update(wallet);
        }
      } else {
        print("Wallet Null");
      }
      update(sWallet);
    });
  }

// Future<List> getAllWallet()  async {
//   Database db = await getDataBase();
//   var result= await db.rawQuery("select * from $simName");
//   return result.toList();
// }
}
