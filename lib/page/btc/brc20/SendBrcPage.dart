import 'dart:io';

import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/page/btc/brc20/InscriptUtxoBean.dart';
import 'package:mvcwallet/page/btc/brc20/TransactionBrc20Page.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../../bean/btc/Brc20Able.dart';
import '../../../bean/btc/BtcUtxoBean.dart';
import '../../../btc/CommonUtils.dart';
import '../../../constant/SimContants.dart';
import '../../../main.dart';
import '../../../utils/SimColor.dart';
import '../../RequestBtcPage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

import '../BtcSignData.dart';
import '../SignBtcTransactionPage.dart';


class SendBrcPage extends StatefulWidget {

  int chooseNum = 1;
  int fee_bg_color = 0xff171AFF;
  int fee_colors_w = 0xffffffff;
  TextEditingController customSatVb = TextEditingController();
  TextEditingController addressController = TextEditingController();

  int colors = 0xffCBCDD6;
  bool isOK=false;
  TransferableList transferable;

  SendBrcPage({Key? key,required this.transferable}) : super(key: key);

  @override
  State<SendBrcPage> createState() => _SendBrcPageState();
}

class _SendBrcPageState extends State<SendBrcPage> {


  InscriptUtxoBean? inscriptUtxoBean;
  BtcSignData? btcSignDatap;
  String? netWorkFee;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.addressController.addListener(() {
      setState(() {
        if(isNoEmpty(widget.addressController.text)){
          widget.isOK=true;
          widget. colors=0xff171AFF;
        }else{
          widget.isOK=false;
          widget. colors=0xffCBCDD6;
        }
      });
    });

    getBtcUtxo();
    getInscriptUtxo();




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
          title: const TitleBack("Send"),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Amount",
                    style: getDefaultTextStyle1(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/input.png"), fit: BoxFit.fill)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child:Align(
                          child: Text(
                            "${widget.transferable.amount} ${widget.transferable.ticker!.toUpperCase()}",
                            style: TextStyle(fontSize: 16),
                          ),
                          alignment: Alignment.centerLeft,
                        )
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    "Receiver",
                    style: getDefaultTextStyle(),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/input.png"), fit: BoxFit.fill)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: "Recipient's address",
                              border: InputBorder.none),
                          controller: widget.addressController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                      child: Text(
                        "Fee Rate",
                        style: getDefaultTextStyle(),
                      ))
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.chooseNum = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
                        height: 100,
                        // width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Color(SimColor.deaful_txt_color),
                                width: 0.5),
                            color: widget.chooseNum == 0
                                ? Color(widget.fee_bg_color)
                                : Color(widget.fee_colors_w)
                            // border:BoxBorder()
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              btcFeeBean!.result!.list![0].title!,
                              style: widget.chooseNum == 0
                                  ? getSelectFeeTextStyleTitle()
                                  : getDefaultFeeTextStyleTitle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${btcFeeBean!.result!.list![0].feeRate} sat/vb",
                              style: widget.chooseNum == 0
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              btcFeeBean!.result!.list![0].desc!,
                              style: widget.chooseNum == 0
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.customSatVb.text = "";
                          widget.chooseNum = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        // width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Color(SimColor.deaful_txt_color),
                                width: 0.5),
                            color: widget.chooseNum == 1
                                ? Color(widget.fee_bg_color)
                                : Color(widget.fee_colors_w)
                            // border:BoxBorder()
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              btcFeeBean!.result!.list![1].title!,
                              style: widget.chooseNum == 1
                                  ? getSelectFeeTextStyleTitle()
                                  : getDefaultFeeTextStyleTitle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${btcFeeBean!.result!.list![1].feeRate} sat/vb",
                              style: widget.chooseNum == 1
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              btcFeeBean!.result!.list![1].desc!,
                              style: widget.chooseNum == 1
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.customSatVb.text = "";
                          widget.chooseNum = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        // width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Color(SimColor.deaful_txt_color),
                                width: 0.5),
                            color: widget.chooseNum == 2
                                ? Color(widget.fee_bg_color)
                                : Color(widget.fee_colors_w)
                            // border:BoxBorder()
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              btcFeeBean!.result!.list![2].title!,
                              style: widget.chooseNum == 2
                                  ? getSelectFeeTextStyleTitle()
                                  : getDefaultFeeTextStyleTitle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${btcFeeBean!.result!.list![2].feeRate} sat/vb",
                              style: widget.chooseNum == 2
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              btcFeeBean!.result!.list![2].desc!,
                              style: widget.chooseNum == 2
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.customSatVb.text = "";
                        widget.chooseNum = 3;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      height: 80,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: Color(SimColor.deaful_txt_color),
                              width: 0.5),
                          color: widget.chooseNum == 3
                              ? Color(widget.fee_bg_color)
                              : Color(widget.fee_colors_w)
                          // border:BoxBorder()
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Custom",
                            style: widget.chooseNum == 3
                                ? getSelectFeeTextStyleTitle()
                                : getDefaultFeeTextStyleTitle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.chooseNum == 3 ? true : false,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/input.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]")),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                                hintText: "sat/vB", border: InputBorder.none),
                            //改变输入的文本信息
                            onChanged: (value) {},
                            controller: widget.customSatVb,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {

                      // Navigator.of(context).push(CupertinoPageRoute(builder:(BuildContext context){
                      //   return TransactionBrc20Page();
                      // }));

                      nextInscribeBrc();




                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Color(widget.colors);
                      }),
                    ),
                    child: const Text("Next", style: TextStyle(fontSize: 16))),
              )
            ],
            // https://docs.scrypt.io/tutorials/hello-word/
          ),
        ));
  }


  num? feedRate = 0;
  void nextInscribeBrc(){
    switch (widget.chooseNum) {
      case 0:
        feedRate = btcFeeBean!.result!.list![0].feeRate;
        break;
      case 1:
        feedRate = btcFeeBean!.result!.list![1].feeRate;
        break;
      case 2:
        feedRate = btcFeeBean!.result!.list![2].feeRate;
        break;
      case 3:
        feedRate = num.parse(widget.customSatVb.text);
        break;
    }


    if(inscriptUtxoBean!=null){
      Utxo utxo=Utxo();
      utxo.txId=inscriptUtxoBean!.data!.txId;
      utxo.satoshi=inscriptUtxoBean!.data!.satoshis;
      utxo.vout=inscriptUtxoBean!.data!.outputIndex;
      utxo.confirmed=true;

      sendBtcTransaction(widget.addressController.text,546,int.parse(feedRate.toString()),utxo);


    }
  }





  int needAmount = 0;

  void sendBtcTransaction(String sendAddress, int sendAmount, int feeVb,Utxo insUtxo) {
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

    utxoNeedList = getNeedUtxoList(sendAmount, utxoList, feeVb, sendAddress, changeAddress,insUtxo);

    if (utxoNeedList.isEmpty) {
      showToast("Insufficient balance");
      return;
    }

    //indo


    // if(myWallet.btcPath=="m/84'/0'/0'/0/0"){

    // }else{
    final seed = bip39.mnemonicToSeed(myWallet.mnemonic);
    final node = bip32.BIP32.fromSeed(seed);
    String wif=node.derivePath(myWallet.btcPath).toWIF();

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
    signData.brc20Amt="${widget.transferable.amount!} ${widget.transferable.ticker!.toUpperCase()}";

    setState(() {
      btcSignDatap=signData;
      netWorkFee="${(signData.netWorkFee! / 100000000).toStringAsFixed(8)} BTC";
      int fee=signData.netWorkFee!;
      int needAmount=signData.sendAmount!;
      int allAmount=fee+needAmount;
      // total="${(allAmount/ 100000000).toStringAsFixed(8)} BTC";



    });


    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
      return TransactionBrc20Page(btcSignData: signData,);
    }));





    // }

  }

  List<Utxo> getNeedUtxoList(int sendAmount, List<Utxo> allUtxoList, int feeVb,
      String sendAddress, String changeAddress,Utxo inUtxo) {
    List<Utxo> utxoNeedList = [];
    needAmount = 0;

    if (allUtxoList!.isNotEmpty) {
      for (var utxo in allUtxoList) {
        if(utxo.confirmed==true){
          needAmount = needAmount + utxo.satoshi!.toInt();
          utxoNeedList.add(utxo);
          if (needAmount > sendAmount) {
            break;
          }
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

    bool isContain=false;

    for (var o in utxoNeedList) {
      if(o.txId==inUtxo.txId){
        isContain=true;
      }
    }

    if(isContain==false){
      print("加入inUtxo");
      utxoNeedList.add(inUtxo);
    }


    if(myWallet.btcAddress.startsWith("bc1q")){
      final p2wpkh = P2WPKH(data: PaymentData(pubkey: alice.publicKey)).data;

      for (int i = 0; i < utxoNeedList.length; i++) {
        Utxo o = utxoNeedList[i];
        if(o.confirmed==true){
          print("加入的utxo: "+o.txId!);
          String inputVout = o!.vout!.toString();
          calTxb.addInput(o.txId, int.parse(inputVout),null,p2wpkh.output);
        }

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
        if(o.confirmed==true){
          String inputVout = o!.vout!.toString();
          calTxb.addInput(o.txId, int.parse(inputVout));
        }
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
          sendAmount, allUtxoList, feeVb, sendAddress, changeAddress,inUtxo);
    }

    // int changeSize=allAmount-sendAmount-feed;
    // print("一次计算找零金额 : ${changeSize}");

    return utxoNeedList;
  }





  Future<void> getInscriptUtxo() async {
    final dio = getHttpDio();
    Map<String, dynamic> map = {};
    map["inscriptionId"] = widget.transferable.inscriptionId;
    try {
      Response response =
      await dio.get(BTC_BRC20_INSCRIPT_UTXO_URL, queryParameters: map);
      if (response.statusCode == HttpStatus.ok) {
        print(response.data.toString());
        // btcUtxoBean=BtcUtxoBean.fromJson(jsonDecode(response.data));
        InscriptUtxoBean getUtxoBean = InscriptUtxoBean.fromJson(response.data);
        setState(() {
          inscriptUtxoBean=getUtxoBean;
        });

      }
    } catch (e) {
      print("获取一次重新获取utxo");
      Future.delayed(const Duration(seconds: 10), () {
        getBtcUtxo();
      });
    }
  }





}
