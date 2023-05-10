import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

///保存数据部分//////////////////////////////
class SharedPreferencesUtils {
  //私有构造函数
  SharedPreferencesUtils._internal();

  //保存单例
  static final SharedPreferencesUtils _singleton =
      SharedPreferencesUtils._internal();

  //工厂构造函数
  factory SharedPreferencesUtils() => _singleton;

  // factory SharedPreferencesUtils(){
  //   return _preferencesUtils;
  // }

  static SharedPreferences? prefs;
}



///钱包实体
class Wallet {
  String mnemonic = "";
  String path = "m/44'/10001'/0'";
  String address = "";
  String balance = "";


  Wallet(this.mnemonic, this.path, this.address, this.balance);

  /// 这个方法在对象转json的时候自动被调用
  Map toJson() {
    Map map ={};
    map["mnemonic"] = mnemonic;
    map["path"] = path;
    map["address"] = address;
    map["balance"] = balance;
    return map;
  }


  /// 因为调用 jsonDecode 把 json 串转对象时，jsonDecode 方法的返回值是 map 类型，无法直接转成 Student 对象
  factory Wallet.fromJson(Map<String, dynamic> parsedJson) {
    Wallet wallet=Wallet( parsedJson['mnemonic'],parsedJson['path'],parsedJson['address'], parsedJson['balance']);
    return wallet;
  }

//将list 对象数据转为  json 格式
// String jsonStr=json.encode(goList);
// 将Json String 数据转为list
// List list = json.decode(jsonStr);


  /// 集合测试部分
  // var goList=[];
  // Wallet wallet=Wallet("net turn first rare glide patient","path1","钱包1地址信息","233.4");
  // goList.add(wallet);
  //
  // Wallet wallet2=Wallet("rare glide patient","path2","钱包2地址信息","2134.67");
  // goList.add(wallet2);
  //
  // Wallet wallet3=Wallet("Apple SD Gothic Neo glide patient","path3","钱包3地址信息","111.67");
  // goList.add(wallet3);
  //
  // goList.removeAt(1);
  //
  // String saveData=goList.join("|");
  // print(goList.toString());

  // String jsonStr=json.encode(goList);
  // print(jsonStr);
  //
  // List resultList=json.decode(jsonStr);
  // Wallet myWallet=resultList[1] as Wallet;
  // print("钱包助记词："+myWallet.mnemonic  +"  余额 ： "+myWallet.balance+"  地址：  "+myWallet.address);
  // print(resultList[1]);
  //
  // Wallet myWallet=Wallet.fromJson(resultList[1]);
  // print("钱包助记词："+myWallet.mnemonic  +"  余额 ： "+myWallet.balance+"  地址：  "+myWallet.address);




}

