
import 'dart:convert';
import 'dart:io';

import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/BtcFeeBean.dart';
import 'package:mvcwallet/bean/btc/BrcIconList.dart';
import 'package:mvcwallet/bean/btc/BtcUtxoBean.dart';
import 'package:mvcwallet/constant/SimContants.dart';
import 'package:mvcwallet/utils/Constants.dart';

import '../bean/btc/BtcBroadcastData.dart';
import '../main.dart';
import '../page/SimpleDialog.dart';
import '../utils/EventBusUtils.dart';


import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;


BtcFeeBean? btcFeeBean;
Future<void> getBtcFee() async{
  final dio =Dio();
  Response response=await dio.get(BTC_FEE_URL);
  if(response.statusCode==HttpStatus.ok){
    // print(response.data.toString());
    // Map<String,dynamic> dataResponse=response.data;

    // BtcFeeBean btcFeeBean=BtcFeeBean.fromJson(response.data);
    btcFeeBean=BtcFeeBean.fromJson(jsonDecode(response.data));
    EventBusUtils.instance.fire(WalletBTCRate(btcFeeBean));
    // print("费率s ： ${btcFeeBean!.result!.list![0].title}");
  }
}


BtcUtxoBean? btcUtxoBean;

Future<void> getBtcUtxo() async{
  final dio =Dio();
  Map<String,dynamic> map={};
  map["address"]=myWallet.btcAddress;
  map["unconfirmed"]=1;
  try{
    Response response=await dio.get(METALET_BTC_UTXO_URL,queryParameters: map);
    if(response.statusCode==HttpStatus.ok){
      print(response.data.toString());
      // btcUtxoBean=BtcUtxoBean.fromJson(jsonDecode(response.data));
      btcUtxoBean=BtcUtxoBean.fromJson(response.data);
      print(btcUtxoBean.toString());

      EventBusUtils.instance.fire(WalletBTCUtxo(btcUtxoBean));
    }
  }catch(e){
    print("获取一次重新获取utxo");
    Future.delayed(const Duration(seconds: 10), () {
      getBtcUtxo();
    });
  }


}


BrcIconList? brcIconList;
Future<void> getBrc20Icon() async{
  final dio =Dio();
  try{
    Response response=await dio.get(BTC_BRC20_ICON_URL);
    if(response.statusCode==HttpStatus.ok){
      print(response.data.toString());
      // btcUtxoBean=BtcUtxoBean.fromJson(jsonDecode(response.data));
      brcIconList=BrcIconList.fromJson(response.data);
      print(brcIconList!.data!.brc20Coin!.ordi!);

      // EventBusUtils.instance.fire(WalletBTCUtxo(btcUtxoBean));
    }
  }catch(e){
    print("获取一次重新获取utxo");
    Future.delayed(const Duration(seconds: 10), () {
      getBrc20Icon();
    });
  }


}


// livenet
void doBroadcastTransaction(BuildContext context,String rawTx,String sendAmount,String receiverAddress) async {
  final dio = Dio();
  final response = await dio.post(BTC_BROADCAST_URL,
      data: {'chain': 'btc', 'net': 'livenet', 'rawTx': rawTx});
  print(response.data.toString());
  Navigator.popUntil(context, ModalRoute.withName("home"));

  if (response.statusCode == HttpStatus.OK) {
    BtcBroadcastData broadcastData = BtcBroadcastData.fromJson(response.data);
    // print("object:" + update.data!.url!);
    if(broadcastData.code==0){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowFtSuccessDialog(
              nftName: "BTC",
              receiveAddress: receiverAddress,
              ftAmount: sendAmount,
              transactionID: broadcastData.data!,
            );
          });
    }else{
      showToast(broadcastData.message!);
    }

  }
}



String get44Address(node, [network]) {
  return P2PKH(data: new PaymentData(pubkey: node.publicKey), network: network)
      .data
      .address;
}



String get84Address(node, [network]) {
  return P2WPKH(data: new PaymentData(pubkey: node.publicKey), network: network)
      .data
      .address;
}
