import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/main.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../dialog/MyWalletDialog.dart';

void showToast(String content) {
  Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0x80000000),
      textColor: Colors.white,
      fontSize: 16.0);
}

String validateInput(String? input) {
  String resut = "";
  if (input == null) {
    return resut;
  }
  if (input.isEmpty) {
    return resut;
  }
  resut = input;
  return resut;
}

bool isNoEmpty(String? input) {
  if (input == null) {
    return false;
  }
  if (input.isEmpty) {
    return false;
  }
  return true;
}

void changeWalletInfo(Wallet wallet) {
  List changeWalletList = [];
  changeWalletList.add(wallet);
  String cacheWallet = json.encode(changeWalletList);
  SharedPreferencesUtils.setValue("mvc_wallet", cacheWallet);
}

void deleteWallet() {
  myWalletList.clear();
  SharedPreferencesUtils.setValue("mvc_wallet", "");
  myWallet = Wallet("", "", "", "0.0", "0", "Wallet");
  // webViewController.runJavaScript("initMetaWallet('','','','')");
  wallets = "";
  spaceBalance = "0.0 Space";
  walletBalance = "\$ 0.0";
}

void initLocalWallet() {
  SharedPreferencesUtils.getString("mvc_wallet", "")
      .then((value) => print("获取报错的钱包： " + value.toString()));
  SharedPreferencesUtils.getString("mvc_wallet", "").then((value) {
    wallets = value;
    SharedPreferencesUtils.getInt("id_key", id).then((value) {
      id = value;
      SharedPreferencesUtils.getInt("selectIndex_key", selectIndex)
          .then((value) {
        selectIndex = value;
        if (wallets.isNotEmpty) {
          myWalletList = json.decode(wallets);
          print("当前的 selectInde$selectIndex");
          print("解析的数组是：" + myWalletList.toString());
          myWallet = Wallet.fromJson(myWalletList[selectIndex]);
          isLogin=true;
          dioRate(myWallet.balance);
        } else {
          print("获取的缓存钱包为空");
        }
      });
    });
  });

  SharedPreferencesUtils.getBool("isUst_key", true)
      .then((value) => isUst = value);

  Timer.periodic(const Duration(seconds: 1), (timer) {
    timeCount -= 1;
    if (timeCount <= 0) {
      String editMnem = myWallet.mnemonic;
      String mne = myWallet.path;
      var seInt = id.toString();
      webViewController
          .runJavaScript("initMetaWallet('$editMnem','$mne','$seInt','${myWallet.name}')");
      timer.cancel();
    }
  });
}


void hasNoLogin(Indo indo){
  showDialog(
      context: navKey.currentState!.overlay!.context,
      builder: (context) {
        return MyWalletDialog(indo: indo, isVisibility: true);
      });
}



///保存数据部分//////////////////////////////
class SharedPreferencesUtils {
  static void setValue(String key, Object? value) {
    if (value is int) {
      setInt(key, value);
    } else if (value is bool) {
      setBool(key, value);
    } else if (value is double) {
      setDouble(key, value);
    } else if (value is String) {
      setString(key, value);
    } else if (value is List<String>) {
      setStringList(key, value);
    }
  }

  static Future getValue<T>(String key, T defaultValue) async {
    if (defaultValue is int) {
      return getInt(key, defaultValue);
    } else if (defaultValue is double) {
      return getDouble(key, defaultValue);
    } else if (defaultValue is bool) {
      return getBool(key, defaultValue);
    } else if (defaultValue is String) {
      return getString(key, defaultValue);
    } else if (defaultValue is List<String>) {
      return getStringList(key);
    }
  }

  static void setInt(String key, int? value, [int defaultValue = 0]) async {
    var sp = await SharedPreferences.getInstance();
    sp.setInt(key, value ?? defaultValue);
  }

  static Future<int> getInt(String key, [int defaultValue = 0]) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getInt(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool? value,
      [bool defaultValue = false]) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setBool(key, value ?? defaultValue);
  }

  static Future<bool> getBool(String key, [bool defaultValue = false]) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getBool(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double? value,
      [double defaultValue = 0.0]) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setDouble(key, value ?? defaultValue);
  }

  static Future<double> getDouble(String key,
      [double defaultValue = 0.0]) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getDouble(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String? value,
      [String defaultValue = '']) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setString(key, value ?? defaultValue);
  }

  static Future<String> getString(String key,
      [String defaultValue = 'false']) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key) ?? defaultValue;
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getStringList(key) ?? List.empty();
  }

  static Future<bool> remove(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool> clearAll() async {
    var sp = await SharedPreferences.getInstance();
    return sp.clear();
  }

  static Future<Set<String>> getKeys() async {
    var sp = await SharedPreferences.getInstance();
    return sp.getKeys();
  }

  static Future<bool> containsKey(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.containsKey(key);
  }
}

///钱包实体
class Wallet {
  String id = "0";
  String name = "Wallet";
  String mnemonic = "";

  // String path = "m/44'/10001'/0'";
  String path = "10001";
  String address = "";
  String balance = "0.0";

  Wallet(
      this.mnemonic, this.path, this.address, this.balance, this.id, this.name);

  /// 这个方法在对象转json的时候自动被调用
  Map toJson() {
    Map map = {};
    map["mnemonic"] = mnemonic;
    map["path"] = path;
    map["address"] = address;
    map["balance"] = balance;
    map["id"] = id;
    map["name"] = name;
    return map;
  }

  /// 因为调用 jsonDecode 把 json 串转对象时，jsonDecode 方法的返回值是 map 类型，无法直接转成 Student 对象
  factory Wallet.fromJson(Map<String, dynamic> parsedJson) {
    Wallet wallet = Wallet(
        parsedJson['mnemonic'],
        parsedJson['path'],
        parsedJson['address'],
        parsedJson['balance'],
        parsedJson['id'],
        parsedJson['name']);
    return wallet;
  }

//将list 对象数据转为  json 格式
// String jsonStr=json.encode(goList);
// 将Json String 数据转为list
// List list = json.decode(jsonStr);
}

void main() {
  /// 集合测试部分
  var goList = [];
  Wallet wallet = Wallet("net turn first rare glide patient", "path1",
      "钱包1地址信息", "233.4", "0", "");
  goList.add(wallet);

  Wallet wallet2 =
      Wallet("rare glide patient", "path2", "钱包2地址信息", "2134.67", "0", "");
  goList.add(wallet2);

  Wallet wallet3 = Wallet("Apple SD Gothic Neo glide patient", "path3",
      "钱包3地址信息", "111.67", "0", "");
  goList.add(wallet3);

  goList.removeAt(1);

  String saveData = goList.join("|");
  print(goList.toString());

  String jsonStr = json.encode(goList);
  print(jsonStr);

  List resultList = json.decode(jsonStr);
  // Wallet myWallet=resultList[1] as Wallet;
  // print("钱包助记词："+myWallet.mnemonic  +"  余额 ： "+myWallet.balance+"  地址：  "+myWallet.address);
  // print(resultList[1]);

  Wallet myWallet = Wallet.fromJson(resultList[1]);
  print("钱包助记词：" +
      myWallet.mnemonic +
      "  余额 ： " +
      myWallet.balance +
      "  地址：  " +
      myWallet.address);
}
