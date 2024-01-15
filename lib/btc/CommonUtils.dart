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
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/utils/Constants.dart';
import '../bean/btc/BtcBroadcastData.dart';
import '../bean/btc/BtcFeeRateBean.dart';
import '../bean/btc/BtcNftBean.dart';
import '../main.dart';
import '../page/SimpleDialog.dart';
import '../page/btc/BtcSignData.dart';
import '../utils/EventBusUtils.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

BtcFeeBean? btcFeeBean;

/*Future<void> getBtcFee() async {
  final dio = getHttpDio();
  Response response = await dio.get(BTC_FEE_URL);
  print("费率s ： "+response.data.toString());
  if (response.statusCode == HttpStatus.ok) {
    // print(response.data.toString());
    // Map<String,dynamic> dataResponse=response.data;

    // BtcFeeBean btcFeeBean=BtcFeeBean.fromJson(response.data);
    btcFeeBean = BtcFeeBean.fromJson(jsonDecode(response.data));
    EventBusUtils.instance.fire(WalletBTCRate(btcFeeBean));
  }
}*/


Future<void> getBtcFee() async {
  final dio = getHttpDio();
  Response response = await dio.get(BTC_FEE_RATE_URL);
  print("费率s ： "+response.data.toString());
  if (response.statusCode == HttpStatus.ok) {
    // print(response.data.toString());
    // Map<String,dynamic> dataResponse=response.data;

    // BtcFeeBean btcFeeBean=BtcFeeBean.fromJson(response.data);
    BtcFeeRateBean btcFeeRateBean = BtcFeeRateBean.fromJson(response.data);
    List<FeeBean> list=[];
    for(int i=0;i<btcFeeRateBean.data!.list!.length;i++){
      FeeRateBean feeRateBean=btcFeeRateBean.data!.list![i];
      FeeBean feeBean=FeeBean();
      feeBean.title=feeRateBean.title;
      feeBean.feeRate=feeRateBean.feeRate;
      feeBean.desc=feeRateBean.desc;
      list.add(feeBean);
    }

    List<FeeBean> reverseList=list.reversed.toList();


    Result result=Result(list: reverseList);
    btcFeeBean=BtcFeeBean(status: "0",message: "ok",result: result);
    print("转换完的结果："+btcFeeBean.toString());
    EventBusUtils.instance.fire(WalletBTCRate(btcFeeBean));

  }
}





BtcUtxoBean? btcUtxoBean;

Future<void> getBtcUtxo() async {
  final dio = getHttpDio();
  Map<String, dynamic> map = {};
  map["address"] = myWallet.btcAddress;
  map["unconfirmed"] = 1;
  try {
    Response response =
        await dio.get(METALET_BTC_UTXO_URL, queryParameters: map);
    if (response.statusCode == HttpStatus.ok) {
      print(response.data.toString());

      btcUtxoBean = BtcUtxoBean.fromJson(response.data);

      // BtcUtxoBean  btcUtxoBeanResult = BtcUtxoBean.fromJson(response.data);
      // btcUtxoBean=BtcUtxoBean();
      // List<Utxo> utxoList=[];
      // for (var o in btcUtxoBeanResult.data!) {
      //   if(o.confirmed!){
      //     utxoList.add(o);
      //   }
      // }
      // btcUtxoBean!.data=utxoList;


      print("获取的utxo :"+btcUtxoBean.toString());


      EventBusUtils.instance.fire(WalletBTCUtxo(btcUtxoBean));
    }
  } catch (e) {
    print("获取一次重新获取utxo");
    Future.delayed(const Duration(seconds: 10), () {
      getBtcUtxo();
    });
  }
}

BrcIconList? brcIconList;

Future<void> getBrc20Icon() async {
  final dio = getHttpDio();
  try {
    Response response = await dio.get(BTC_BRC20_ICON_URL);
    if (response.statusCode == HttpStatus.ok) {
      print(response.data.toString());
      // btcUtxoBean=BtcUtxoBean.fromJson(jsonDecode(response.data));
      brcIconList = BrcIconList.fromJson(response.data);
      print(brcIconList!.data!.brc20Coin!.ordi!);

      // EventBusUtils.instance.fire(WalletBTCUtxo(btcUtxoBean));
    }
  } catch (e) {
    print("获取一次重新获取utxo");
    Future.delayed(const Duration(seconds: 10), () {
      getBrc20Icon();
    });
  }
}





List<BtcNftBeanList> btcNftResult =[];

//get Data
Future<void> getNftData() async {
  print("初始化NFT");
  btcNftResult.clear();
  Map<String, dynamic> map = {};
  map["address"] = myWallet.btcAddress;
  map["size"] = 12;
  map["cursor"] = 0;
  Dio dio = getHttpDio();
  Response response = await dio.get(BTC_BRC20_NFT_URL, queryParameters: map);

  Map<String, dynamic> data = response.data;
  BtcNftBean nftData = BtcNftBean.fromJson(data);
  List<BtcNftBeanList> myNftList = nftData.data!.btcNftBeanList!;
  print("大小："+myNftList.length.toString());

  for(int i=0;i<myNftList.length;i++){
    BtcNftBeanList bean=myNftList[i];
    Dio dio = getHttpDio();
    Response response = await dio.get(bean.content!, queryParameters: map);
    bean.nftShowContent=response.data.toString();
    btcNftResult.add(bean);
  }

}



void goAndClosePage(BuildContext context,Widget widget){
  Navigator.pushAndRemoveUntil(
      context,
       MaterialPageRoute(builder: (context) => widget),
          (route) => route == null);
}


void showDefaultLoading(BuildContext context,int second){
  showDialog(
      context: context,
      builder: (context) {
        return ProgressDialog(isShow: true);
      });

  Future.delayed( Duration(seconds: second),(){
    Navigator.of(context).pop();
  });
}


void showLoading(BuildContext context){
  showDialog(
      context: context,
      builder: (context) {
        return ProgressDialog(isShow: true);
      });
}

void dismissLoading(BuildContext context){
  // Future.delayed( Duration(seconds: second),(){
  //
  // });

  Navigator.of(context).pop();
}


void delayedDoSomeThing(Function function){
  Future.delayed( Duration(seconds: 2),(){
    function();
  });
}



DateTime? _lastTime;
preventDoubleTap({int? interval}){
  DateTime _nowTime = DateTime.now();
  if(_lastTime == null || _nowTime.difference(_lastTime!) > Duration(milliseconds: interval??300)){
    _lastTime = _nowTime;
    return true;
  }else {
    _lastTime = _nowTime;
    return false;
  }
}



// livenet
void doBroadcastTransaction(BuildContext context, String rawTx,
    String sendAmount, String receiverAddress) async {
  final dio = Dio();
  final response = await dio.post(BTC_BROADCAST_URL,
      data: {'chain': 'btc', 'net': 'livenet', 'rawTx': rawTx});
  print(response.data.toString());
  Navigator.popUntil(context, ModalRoute.withName("home"));

  if (response.statusCode == HttpStatus.OK) {
    BtcBroadcastData broadcastData = BtcBroadcastData.fromJson(response.data);
    // print("object:" + update.data!.url!);
    if (broadcastData.code == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowFtSuccessDialog(
              nftName: "",
              receiveAddress: receiverAddress,
              ftAmount: sendAmount,
              transactionID: broadcastData.data!,
            );
          });
    } else {
      showToast(broadcastData.message!);
    }
  }
}

BaseOptions options = BaseOptions(
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  validateStatus: (status){
    return true;
  }
);
Dio dio = Dio(options);
// Dio dio = Dio();

Dio getHttpDio() {
  if (dio == null) {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
  }
  return dio;
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


//BTC Trans
int needAmount = 0;

void sendBtcTransaction(String sendAddress, int sendAmount, int feeVb,SendBtcTransIndo sendBtcTransIndo) {

  print("交易数据传入是：sendAddress "+sendAddress );
  print("交易数据传入是：sendAmount "+sendAmount.toString() );
  print("交易数据传入是：feeVb "+feeVb.toString() );


  List<Utxo> utxoList = [];
  List<Utxo> utxoNeedList = [];
  needAmount = 0;
  int changeSize = 546;
  String changeAddress = myWallet.btcAddress;

  if (btcUtxoBean!.data!.isNotEmpty) {
    utxoList = btcUtxoBean!.data!;
    for (var utxo in utxoList) {
      needAmount = needAmount + utxo.satoshi!.toInt();
      // utxoNeedList.add(utxo);
      if (needAmount > sendAmount) {
        break;
      }
    }
  } else {
    showToast("Insufficient balance 1");
    return;
  }

  // 没有进入break
  if (needAmount <= sendAmount) {
    showToast("Insufficient balance");
    return;
  }

  utxoNeedList = getNeedUtxoList(sendAmount, utxoList, feeVb, sendAddress, changeAddress);

  if (utxoNeedList.isEmpty) {
    showToast("Insufficient balance");
    return;
  }

  // if(myWallet.btcPath=="m/84'/0'/0'/0/0"){

  // }else{
  final seed = bip39.mnemonicToSeed(myWallet.mnemonic);
  final node = bip32.BIP32.fromSeed(seed);
  String wif=node.derivePath(myWallet.btcPath).toWIF();
  print("wif:  ${wif}");
  //1.设置input 和 out put
  // var alice = ECPair.fromWIF(node.toWIF());
  var alice = ECPair.fromWIF(wif);

  var calTxb = TransactionBuilder();

  if(myWallet.btcAddress.startsWith("bc1q")){
    final p2wpkh = P2WPKH(data: PaymentData(pubkey: alice.publicKey)).data;

    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String inputVout = o!.vout!.toString();
      calTxb.addInput(o.txId, int.parse(inputVout),null,p2wpkh.output);
    }

    calTxb.addOutput(sendAddress, sendAmount);
    calTxb.addOutput(changeAddress, changeSize);

    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String satoshi = o!.satoshi!.toString();
      calTxb.sign(vin: i, keyPair: alice,witnessValue: int.parse(satoshi));
    }
  }else{
    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String inputVout = o!.vout!.toString();
      calTxb.addInput(o.txId, int.parse(inputVout));
    }

    calTxb.addOutput(sendAddress, sendAmount);
    calTxb.addOutput(changeAddress, changeSize);

    for (int i = 0; i < utxoNeedList.length; i++) {
      calTxb.sign(vin: i, keyPair: alice);
    }
  }


  //计算体积
  Transaction transactionCal = calTxb.buildIncomplete();
  int vbSize = transactionCal.virtualSize();
  print("计算体积大小: ${vbSize}");

  // 计算手续费
  int feed = vbSize * feeVb;
  print("计算手续费: ${feed}");

  changeSize = needAmount - sendAmount - feed;
  print("计算找零金额 : ${changeSize}");

  if (changeSize<0) {
    showToast("Insufficient balance");
    return;
  }


  //build transaction
  TransactionBuilder linkTranBuild=TransactionBuilder();
  linkTranBuild.setVersion(1);

  BtcSignData signData=BtcSignData();

  if(myWallet.btcAddress.startsWith("bc1q")){
    print("最总上链加入bc1q");
    final p2wpkh = P2WPKH(data: PaymentData(pubkey: alice.publicKey)).data;
    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String inputVout = o!.vout!.toString();
      signData.inputUtxos!.add(o.satoshi.toString());
      print("utxoTxID: "+o.txId!);
      print("inputVout: "+inputVout);
      linkTranBuild.addInput(o.txId!, int.parse(inputVout),null,p2wpkh.output);
    }

    // linkTranBuild.addOutput(sendAddress, sendAmount);
    // linkTranBuild.addOutput(changeAddress, changeSize);
    //
    // for (int i = 0; i < utxoNeedList.length; i++) {
    //   Utxo o = utxoNeedList[i];
    //   String satoshi = o!.satoshi!.toString();
    //   linkTranBuild.sign(vin: i, keyPair: alice,witnessValue: int.parse(satoshi));
    // }

  }else{
    print("最总上链加入");
    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      signData.inputUtxos!.add(o.satoshi.toString());
      String inputVout = o!.vout!.toString();
      linkTranBuild.addInput(o.txId, int.parse(inputVout));
    }
    // linkTranBuild.addOutput(sendAddress, sendAmount);
    // linkTranBuild.addOutput(changeAddress, changeSize);
    //
    // for (int i = 0; i < utxoNeedList.length; i++) {
    //   Utxo o = utxoNeedList[i];
    //   String satoshi = o!.satoshi!.toString();
    //   linkTranBuild.sign(vin: i, keyPair: alice,witnessValue: int.parse(satoshi));
    // }
  }


  linkTranBuild.addOutput(sendAddress, sendAmount);
  linkTranBuild.addOutput(changeAddress, changeSize);

  signData.outputUtxos!.add(sendAmount.toString());
  signData.changeAmount=changeSize.toString();


  for (int i = 0; i < utxoNeedList.length; i++) {
    Utxo o = utxoNeedList[i];
    String satoshi = o!.satoshi!.toString();
    print("这个Utxo大小是："+satoshi);
    linkTranBuild.sign(vin: i, keyPair: alice,witnessValue: int.parse(satoshi));
  }


  Transaction transaction=linkTranBuild.buildIncomplete();
  int vbSize3 = transaction.virtualSize();
  print("真实上链体积 ：$vbSize3 vb");

  String rawTx=linkTranBuild.build().toHex();

  print("上链rawTx: "+rawTx);

  //brocast


  signData.utxoNeedList=utxoNeedList;
  signData.netWorkFee=feed;
  signData.netWorkFeeRate=feeVb;
  signData.sendtoAddress=sendAddress;
  signData.sendAmount=sendAmount;
  signData.rawTx=rawTx;

  sendBtcTransIndo.sendBtcTransResult(signData);




  // }

}

List<Utxo> getNeedUtxoList(int sendAmount, List<Utxo> allUtxoList, int feeVb,
    String sendAddress, String changeAddress) {
  List<Utxo> utxoNeedList = [];
  needAmount = 0;

  if (allUtxoList!.isNotEmpty) {
    for (var utxo in allUtxoList) {
      needAmount = needAmount + utxo.satoshi!.toInt();
      utxoNeedList.add(utxo);
      if (needAmount > sendAmount) {
        break;
      }
    }
  }

  if (needAmount <= sendAmount) {
    utxoNeedList = [];
    // showToast("Insufficient balance");
    return utxoNeedList;
  }

  final seed = bip39.mnemonicToSeed(myWallet.mnemonic);
  final node = bip32.BIP32.fromSeed(seed);
  //1.设置input 和 out put
  var alice = ECPair.fromWIF(node.toWIF());

  var calTxb = TransactionBuilder();



  if(myWallet.btcAddress.startsWith("bc1q")){
    final p2wpkh = P2WPKH(data: PaymentData(pubkey: alice.publicKey)).data;

    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String inputVout = o!.vout!.toString();
      calTxb.addInput(o.txId, int.parse(inputVout),null,p2wpkh.output);
    }

    calTxb.addOutput(sendAddress, 1000);
    calTxb.addOutput(changeAddress, 546);

    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String satoshi = o!.satoshi!.toString();
      calTxb.sign(vin: i, keyPair: alice,witnessValue: int.parse(satoshi));
    }

  }else{

    print("进入p2pKh");
    for (int i = 0; i < utxoNeedList.length; i++) {
      Utxo o = utxoNeedList[i];
      String inputVout = o!.vout!.toString();
      calTxb.addInput(o.txId, int.parse(inputVout));
    }

    calTxb.addOutput(sendAddress, 1000);
    calTxb.addOutput(changeAddress, 546);

    for (int i = 0; i < utxoNeedList.length; i++) {
      calTxb.sign(vin: i, keyPair: alice);
    }
  }



  //计算体积
  Transaction transactionCal = calTxb.buildIncomplete();
  int vbSize = transactionCal.virtualSize();
  print("一次计算体积大小: ${vbSize}");

  // 计算手续费
  int feed = vbSize * feeVb;
  print("一次计算手续费: ${feed}");



  if(feed>10000000){
    utxoNeedList = [];
    // showToast("Insufficient balance");
    return utxoNeedList;
  }


  sendAmount = sendAmount + feed;

  print("needAmount: "+needAmount.toString());
  print("sendAmount: "+sendAmount.toString());

  if (needAmount < sendAmount) {
    print("进入二次计算1111111111111");
    utxoNeedList = getNeedUtxoList(
        sendAmount, allUtxoList, feeVb, sendAddress, changeAddress);
  }

  // int changeSize=allAmount-sendAmount-feed;
  // print("一次计算找零金额 : ${changeSize}");

  return utxoNeedList;
}
