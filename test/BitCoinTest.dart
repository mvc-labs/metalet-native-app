import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'dart:developer';

import 'package:logger/logger.dart';

void main() {
  // var seed = bip39.mnemonicToSeed("net turn first rare glide patient mask hungry damp cabbage umbrella ostrich");
  var seed = bip39.mnemonicToSeed(
      "mean jazz arena artefact type six remain space truck bench later brisk");

  var wallet = HDWallet.fromSeed(seed);
  HDWallet btWallet = wallet.derivePath("m/44'/236'/0'/0/0");

//  正式使用
  int utxoAmount = 10000;
  String utxtTxID = "a44052e5c9234d36786f9f68f1c3a16828e957b6ffc42557093c5a4bc7443b01";
  // print("获取的私钥是: ${btWallet.wif}");

  //1.设置input 和 out put
  var alice = ECPair.fromWIF(btWallet.wif);
  var calTxb = TransactionBuilder();
  calTxb.setVersion(1);
  calTxb.addInput(utxtTxID, 0,);
  calTxb.addOutput("12aQen58y82vAv8bpgF3DPeWfUnRizecQ6", 700); //转账给对方 500 sat
  calTxb.addOutput("1M9uy3uiK6rhHVmsguzVdL7GoKP64Ff43V", 546);  //假定的找零金额
  calTxb.sign(vin: 0, keyPair: alice);

  //2.计算体积
  Transaction transa = calTxb.buildIncomplete();
  int vbSize = transa.virtualSize(); //体积大小
  print("体积1：$vbSize vb");

  //3.计算手续费 费率设定 30 vb/sat
  int fee = vbSize * 35;

  //4.计算找零金额
  int changeSize = utxoAmount - 700 - fee;
  print("fee：$fee sat");


  //5.构建上链交易
  var txb = TransactionBuilder();
  txb.setVersion(1);
  txb.addInput(utxtTxID, 0,);
  txb.addOutput("12aQen58y82vAv8bpgF3DPeWfUnRizecQ6", 700); //转账给对方 500 sat
  txb.addOutput("1M9uy3uiK6rhHVmsguzVdL7GoKP64Ff43V", changeSize);  //假定的找零金额
  txb.sign(vin: 0, keyPair: alice);
  String rawTx = txb.buildIncomplete().toHex();
  String rawTx2 = txb.build().toHex();
  int vbSize3 = txb.build().virtualSize();
  print("真实上链体积 ：$vbSize3 vb");
  print(rawTx);
  print(rawTx2);




//  clone 函数有点问题 后续在看
/*  int utxoAmount=10000;
  String utxtTxID="a44052e5c9234d36786f9f68f1c3a16828e957b6ffc42557093c5a4bc7443b01";
  // print("获取的私钥是: ${btWallet.wif}");
  //1.设置input 和 out put
  var alice=ECPair.fromWIF(btWallet.wif);
  var txb=TransactionBuilder();
  txb.setVersion(1);
  txb.addInput(utxtTxID, 0,);
  txb.addOutput("12aQen58y82vAv8bpgF3DPeWfUnRizecQ6", 700);//转账给对方 500 sat
  txb.addOutput("1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9", 546); //假定的找零金额
  txb.sign(vin: 0, keyPair: alice);


  // 2.clone transaction
  Transaction transaction=txb.build();
  TransactionBuilder calTxb= TransactionBuilder.fromTransaction(transaction);
  calTxb.addOutput("1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9", 546); //假定的找零金额
  calTxb.sign(vin: 0, keyPair: alice);
  Transaction tx= calTxb.buildIncomplete();
  int vbSize2=tx.virtualSize(); //体积大小
  print("体积2：$vbSize2 vb");



  //3.计算手续费 费率设定 30 vb/sat
  // int vbSize=txb.tx.virtualSize();
  int fee=vbSize2*30;
  int changeSize=utxoAmount-700-fee;
  print("fee：$fee sat");
  print("体积changeSize ：$changeSize vb");
  */

  //测试通过

  /*int utxoAmount=10000;
  String utxtTxID="a44052e5c9234d36786f9f68f1c3a16828e957b6ffc42557093c5a4bc7443b01";
  // print("获取的私钥是: ${btWallet.wif}");
  //1.设置input 和 out put
  var alice=ECPair.fromWIF(btWallet.wif);
  var txb=TransactionBuilder();
  txb.setVersion(1);
  txb.addInput(utxtTxID, 0,);
  txb.addOutput("12aQen58y82vAv8bpgF3DPeWfUnRizecQ6", 700);//转账给对方 500 sat
  // txb.addOutput("1M9uy3uiK6rhHVmsguzVdL7GoKP64Ff43V", 546);  //假定的找零金额
  txb.sign(vin: 0, keyPair: alice);
  Transaction transa= txb.buildIncomplete();
  int vbSize1=transa.virtualSize(); //体积大小
  print("体积1：$vbSize1 vb");

  // 2.clone transaction
  Transaction transaction=txb.buildIncomplete();
  TransactionBuilder calTxb= TransactionBuilder.fromTransaction(transaction);
  calTxb.addOutput("1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9", 546);
  calTxb.sign(vin: 0, keyPair: alice);
  int vbSize2=calTxb.tx.virtualSize(); //体积大小
  print("体积2：$vbSize2 vb");

  //3.计算手续费 费率设定 30 vb/sat
  // int vbSize=txb.tx.virtualSize();
  int fee=vbSize2*30;
  int changeSize=utxoAmount-700-fee;
  print("fee：$fee sat");
  print("体积changeSize ：$changeSize vb");



  //4.构建上链交易
  // int changeSize=utxoAmount-700-fee; //实际找零金额
  // txb.addOutput("1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9", changeSize);// 这里是不是应该替换原来的outPut ?
  // txb.sign(vin: 0, keyPair:alice);
  // String rawTx= txb.build().toHex();
  // print(rawTx);




  // var alice=ECPair.fromWIF(btWallet.wif);
  var txb3=TransactionBuilder();
  txb3.setVersion(1);
  txb3.addInput(utxtTxID, 0,);
  txb3.addOutput("12aQen58y82vAv8bpgF3DPeWfUnRizecQ6", 700);//转账给对方 500 sat
  txb3.addOutput("1M9uy3uiK6rhHVmsguzVdL7GoKP64Ff43V", changeSize);
  txb3.sign(vin: 0, keyPair:alice);
  String rawTx= txb3.buildIncomplete().toHex();
  int vbSize3=txb3.buildIncomplete().virtualSize();
  print("体积3：$vbSize3 vb");
  print(rawTx);*/
}
