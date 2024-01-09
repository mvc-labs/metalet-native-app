import 'dart:convert';
import 'dart:io';

import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/btc/Brc20CommitRequest.dart';
import 'package:mvcwallet/bean/btc/Brc20PreDataBean.dart';
import 'package:mvcwallet/page/btc/BtcSignData.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../../bean/btc/Brc20Able.dart';
import '../../../bean/btc/BtcUtxoBean.dart';
import '../../../btc/CommonUtils.dart';
import '../../../data/Indo.dart';
import '../../../main.dart';
import '../../../utils/Constants.dart';
import '../../RequestBtcPage.dart';
import 'Brc20JsonBean.dart';
import 'InscribeBrcTranPage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

class InscribeBrcPrePage extends StatefulWidget {

  int chooseNum = 1;
  int fee_bg_color = 0xff171AFF;
  int fee_colors_w = 0xffffffff;
  int colors = 0xffCBCDD6;
  bool isOK=false;


  Brc20PreDataBean brc20preDataBean;
  Brc20JsonBean brc20jsonBean;


  InscribeBrcPrePage({Key? key,required this.brc20preDataBean,required this.brc20jsonBean}) : super(key: key);

  @override
  State<InscribeBrcPrePage> createState() => _InscribeBrcPrePageState();
}

class _InscribeBrcPrePageState extends State<InscribeBrcPrePage> implements SendBtcTransIndo{

  var needAmount1;
  String netWorkFee="0";
  String total="0";

  BtcSignData? btcSignDatap;
  Brc20CommitRequest? brc20commitRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String payAddress=widget.brc20preDataBean.data!.payAddress!;
    String feedRate=widget.brc20preDataBean.data!.networkFeeRate!.toString();
    needAmount1 = (widget.brc20preDataBean.data!.needAmount! / 100000000).toStringAsFixed(8);
    // var netWorkFee = (widget.brc20preDataBean.data!.needAmount! / 100000000).toStringAsFixed(8);
    Brc20JsonBean brc20jsonBeanShow=Brc20JsonBean(p: widget.brc20jsonBean.p, op: widget.brc20jsonBean.op, tick: widget.brc20jsonBean.tick, amt: "546");
    brc20commitRequest =Brc20CommitRequest(widget.brc20jsonBean.tick!,widget.brc20jsonBean.amt!,widget.brc20preDataBean.data!.orderId!,jsonEncode(brc20jsonBeanShow.toJson()));


    // sendBtcTransaction(payAddress,int.parse(widget.brc20preDataBean.data!.needAmount!.toString()),int.parse(feedRate),this);

    sendBtcTransaction(payAddress,int.parse(widget.brc20preDataBean.data!.needAmount!.toString()),int.parse(feedRate));
  }



  int needAmount = 0;

  void sendBtcTransaction(String sendAddress, int sendAmount, int feeVb) {
    List<Utxo> utxoList = [];
    List<Utxo> utxoNeedList = [];

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
      showToast("钱包初始化中");
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


    setState(() {
      btcSignDatap=signData;
      netWorkFee="${(signData.netWorkFee! / 100000000).toStringAsFixed(8)} BTC";
      int fee=signData.netWorkFee!;
      int needAmount=signData.sendAmount!;
      int allAmount=fee+needAmount;
      total="${(allAmount/ 100000000).toStringAsFixed(8)} BTC";
    });


    // Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
    //   return SignBtcTransactionPage(btcSignData: signData,);
    // }));





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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TitleBack("Inscribe Transfer"),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("${widget.brc20jsonBean.amt} ${widget.brc20jsonBean.tick}",style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
                  color: Color(SimColor.deaful_txt_color)
                ),),
              ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Preview",style: getDefaultTextStyle1(),),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(SimColor.color_bg_gray2),
                ),
                child: Text(jsonEncode(widget.brc20jsonBean.toJson()),style: getDefaultTextStyle(),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Network Fee",style: getDefaultGrayTextStyle16(),),

                  Text(netWorkFee,style: getDefaultTextStyle1(),)
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Need Amount",style: getDefaultGrayTextStyle16(),),

                  Text("$needAmount1 BTC",style: getDefaultTextStyle1(),)
                ],
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: getDefaultTextStyle1(),),
                  Text(total,style: getDefaultTextStyle1(),)
                ],
              ),
             Expanded(child: Text("")),
              Container(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(SimColor.color_button_blue))
                    ),
                    onPressed: (){
                      if(btcSignDatap!=null){
                        print(brc20commitRequest.toString());
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => InscribeBrcTranPrePage(brc20commitRequest: brc20commitRequest!,btcSignData: btcSignDatap!,)),
                        //         (route) => route == null);

                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(builder: (context)=> InscribeBrcTranPrePage(brc20commitRequest: brc20commitRequest!,btcSignData: btcSignDatap!,))
                        );

                        // Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
                        //   return InscribeBrcTranPrePage(brc20commitRequest: brc20commitRequest!,btcSignData: btcSignDatap!,);
                        // }));
                      }
                    },child: const Text("Next", style: TextStyle(fontSize: 16))),
              ),
              Expanded(child: Text("")),

            ],
          ),
        ));
  }


  @override
  void sendBtcTransResult(BtcSignData btcSignData) {
    // TODO: implement sendBtcTransResult
    print("计算的交易： "+btcSignData.toString());
    setState(() {
      // btcSignData.inputUtxos!.add("11111");
      btcSignDatap=btcSignData;
      netWorkFee="${(btcSignData.netWorkFee! / 100000000).toStringAsFixed(8)} BTC";
      int fee=btcSignData.netWorkFee!;
      int needAmount=btcSignData.sendAmount!;
      int allAmount=fee+needAmount;
      total="${(allAmount/ 100000000).toStringAsFixed(8)} BTC";


    });



  }












}
