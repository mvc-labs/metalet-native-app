// ignore_for_file: no_logic_in_create_state

import 'dart:async';
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/btc/BtcSignData.dart';
import 'package:mvcwallet/utils/Constants.dart';
import '../../bean/btc/BtcUtxoBean.dart';
import '../../utils/EventBusUtils.dart';
import '../../utils/SimColor.dart';
import '../../utils/SimStytle.dart';
import '../ScanPage.dart';
import '../SimpleDialog.dart';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

import 'SignBtcTransactionPage.dart';

class SendBtcPage extends StatefulWidget {
  final String result;
  bool isScan;

  SendBtcPage({Key? key, required this.result, required this.isScan})
      : super(key: key);

  @override
  State<SendBtcPage> createState() => _SendBtcPageState(result);
}

class _SendBtcPageState extends State<SendBtcPage> {
  final String sResult;

  _SendBtcPageState(this.sResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        //响应物理按键
        child: WillPopScope(
          onWillPop: () async {
            if (widget.isScan) {
              Navigator.of(context)
                ..pop()
                ..pop();
            } else {
              Navigator.of(context).pop();
            }
            return false;
          },
          child: Column(
            children: [
              TitleBack2(
                "Send",
                onPressed: () {
                  if (widget.isScan) {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              ScanResultContent(
                lastResult: sResult,
              )
              // Scrollbar(child: SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   child: ScanResultContent(
              //     lastResult: sResult,
              //   ),
              // ))
            ],
          ),
        ),
      ),
    );
  }
}

class ScanResultContent extends StatefulWidget {
  String lastResult;
  bool isOK = false;
  double amount = 0;
  // int colors = 0x80171AFF;
  int colors = 0xffCBCDD6;
  //Fee
  int fee_colors_w = 0xffffffff;
  int fee_colors_text = 0xff303133;
  int fee_text_color = 0xff303133;
  int fee_bg_color = 0xff171AFF;

  int chooseNum = 1;

  TextEditingController amountController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController customSatVb = TextEditingController();

  ScanResultContent({Key? key, required this.lastResult}) : super(key: key) {
    addressController =
        TextEditingController.fromValue(TextEditingValue(text: lastResult));
    // amountController =
    //     TextEditingController.fromValue(const TextEditingValue(text: "0"));
  }

  @override
  State<ScanResultContent> createState() => _ScanResultContentState();
}

class _ScanResultContentState extends State<ScanResultContent> {
  late StreamSubscription _subscription_btc_rate;
  late StreamSubscription _subscription_btc_utxo;

  @override
  void initState() {
    super.initState();
    widget.amountController.addListener(() {
      // showToast(widget.amountController.text);
      print(widget.amountController.text);
      setState(() {
        if (isNoEmpty(widget.amountController.text)) {
          widget.amount = double.parse(widget.amountController.text);
          if (isNoEmpty(widget.lastResult) && widget.amount > 0) {
            // showToast("1111111111111111111111");
            widget.isOK = true;
            widget.colors = 0xff171AFF;
          } else {
            // showToast("22222222222222222222");
            widget.isOK = false;
            widget.colors = 0xffCBCDD6;
          }
        } else {
          // showToast("333333");
          widget.isOK = false;
          widget.colors = 0xffCBCDD6;
        }
      });
    });

    widget.addressController.addListener(() {
      print(widget.addressController.text);
      setState(() {
        widget.lastResult = widget.addressController.text;
        if (isNoEmpty(widget.lastResult) && widget.amount > 0) {
          widget.isOK = true;
          widget.colors = 0xff171AFF;
        } else {
          widget.isOK = false;
          widget.colors = 0xffCBCDD6;
        }
      });
    });

    _subscription_btc_rate =
        EventBusUtils.instance.on<WalletBTCRate>().listen((event) {
      // print(event.);
      setState(() {
        btcFeeBean = event!.btcFeeBean;
      });
    });

    _subscription_btc_utxo =
        EventBusUtils.instance.on<WalletBTCUtxo>().listen((event) {
      setState(() {
        btcUtxoBean = event!.btcUtxoBean;
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription_btc_rate.cancel();
    _subscription_btc_utxo.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
        child: Column(
          children: [
            Container(
              height: 70,
              // decoration: BoxDecoration(color: Colors.red),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "images/btc_icon.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    "Balance",
                                    style: TextStyle(
                                        color: Color(
                                            SimColor.deaful_txt_half_color),
                                        fontSize: 14),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(btcBalance,
                                      style: const TextStyle(
                                          color:
                                              Color(SimColor.deaful_txt_color),
                                          fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Address",
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
                            hintText: "Transfer address",
                            border: InputBorder.none),
                        //改变输入的文本信息
                        onChanged: (value) {
                          // widget.lastResult = value;
                          // setState(() {
                          //   widget.lastResult = value;
                          //   if (isNoEmpty(widget.lastResult) &&
                          //       widget.amount > 0) {
                          //     widget.isOK = true;
                          //     widget.colors = 0xff171AFF;
                          //   } else {
                          //     widget.isOK = false;
                          //     widget.colors = 0x80171AFF;
                          //   }
                          // });
                        },
                        controller: widget.addressController,
                      ),
                    ),
                  ),
                  // Image.asset("images/mvc_scan_icon.png",
                  //     width: 20, height: 20),

                  //TODO scan
                  /* TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return const ScanPage();
                      }));
                    },
                    child: Image.asset("images/mvc_scan_icon.png",
                        width: 20, height: 20),
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Transfer Amount",
                  style: getDefaultTextStyle(),
                  textAlign: TextAlign.left,
                ))
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
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          hintText: "0", border: InputBorder.none),
                      onChanged: (value) {
                        // widget.amount = double.parse(value);
                        // setState(() {
                        //   widget.amount = double.parse(value);
                        //   if (isNoEmpty(widget.lastResult) &&
                        //       widget.amount > 0) {
                        //     widget.isOK = true;
                        //     widget.colors = 0xff171AFF;
                        //   } else {
                        //     widget.isOK = false;
                        //     widget.colors = 0x80171AFF;
                        //   }
                        // });
                      },
                      controller: widget.amountController,
                    ),
                  ),
                  const Text("BTC"),
                  const SizedBox(width: 10)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Fee",
                  style: getDefaultTextStyle(),
                ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
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
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
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
                    if(!preventDoubleTap()){
                      return;
                    }

                    send(widget.addressController.text,
                        widget.amountController.text);
                    // if (isFingerCan) {
                    //   authenticateMe().then((value) {
                    //     if (value) {
                    //       //正确
                    //       send(widget.addressController.text,
                    //           widget.amountController.text);
                    //     }
                    //   });
                    // } else {
                    //   //  TODO 继续
                    //   send(widget.addressController.text,
                    //       widget.amountController.text);
                    // }
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
        ));
  }

  num? feedRate = 45;

  void send(String address, String amount) {
    if (address.isNotEmpty && amount.isNotEmpty) {
      // if(Address.validateAddress(address)){
      // if (Address.validateAddress(address)) {

      showLoading(context);
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
        // if(widget.chooseNum==0){
        //
        // }else if(widget.chooseNum)

        double sendAmount = double.parse(amount) * 100000000;
        print("address $address");
        print(
            "sendAmount ${Decimal.parse(sendAmount.toString()).toStringAsFixed(0)}");
        print("balance:  ${double.parse(myWallet.btcBalance) * 100000000}");
        // if(sendAmount<double.parse(myWallet.btcBalance)){

         double sendAmountAddGas=sendAmount+3000;
        if (sendAmountAddGas < double.parse(myWallet.btcBalance) * 100000000) {
          FocusScope.of(context).unfocus();
          var valueRe = Decimal.parse(sendAmount.toString()).toStringAsFixed(0);
          // showToast("SendAmount: $valueRe feedRate: $feedRate sat/vb");

          sendBtcTransaction(address, int.parse(valueRe), int.parse(feedRate.toString()));

          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return ProgressDialog(isShow: true);
          //     });
          // isSendFinish=false;
          // webViewController.runJavaScript("send('$address','$valueRe')");
          //
          // Future.delayed(const Duration(seconds: 6),(){
          //   if(isSendFinish==false){
          //     Navigator.of(context).pop();
          //     showToast("Send failed Please check the address");
          //   }
          //   isSendFinish=true;
          // });
        } else {
          dismissLoading(context);
          showToast("Insufficient transfer balance");
        }
      // } else {
      //   print("地址错误");
      //   showToast("Send failed Please check the address");
      // }
    }
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
      showToast("Insufficient balance 1");
      dismissLoading(context);
      return;
    }

    // 没有进入break
    if (needAmount <= sendAmount) {
      showToast("Insufficient balance");
      dismissLoading(context);
      return;
    }

    utxoNeedList = getNeedUtxoList(sendAmount, utxoList, feeVb, sendAddress, changeAddress);

    if (utxoNeedList.isEmpty) {
      showToast("Insufficient balance");
      dismissLoading(context);
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
      dismissLoading(context);
      return;
    }


    //build transaction
    TransactionBuilder linkTranBuild=TransactionBuilder();
    linkTranBuild.setVersion(1);


    if(myWallet.btcAddress.startsWith("bc1q")){
      print("最总上链加入bc1q");
      final p2wpkh = P2WPKH(data: PaymentData(pubkey: alice.publicKey)).data;
      for (int i = 0; i < utxoNeedList.length; i++) {
        Utxo o = utxoNeedList[i];
        String inputVout = o!.vout!.toString();

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

    BtcSignData signData=BtcSignData();
    signData.utxoNeedList=utxoNeedList;
    signData.netWorkFee=feed;
    signData.netWorkFeeRate=feeVb;
    signData.sendtoAddress=sendAddress;
    signData.sendAmount=sendAmount;
    signData.rawTx=rawTx;

    // dismissLoading(context);
    Future.delayed( Duration(seconds: 2),(){
      dismissLoading(context);
      Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
        return SignBtcTransactionPage(btcSignData: signData,);
      }));
    });



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

}



// void sendBtcTransaction(String sendAddress,int sendAmount,int feeVb){
//
//   List<Utxo> utxoList=[];
//   List<Utxo> utxoNeedList=[];
//
//   int changeSize=546;
//   String changeAddress=myWallet.btcAddress;
//
//
//
//   if(btcUtxoBean!.data!.isNotEmpty){
//     utxoList=btcUtxoBean!.data!;
//     for (var utxo in utxoList) {
//       needAmount=needAmount+utxo.satoshi!.toInt();
//       // utxoNeedList.add(utxo);
//       if(needAmount>sendAmount){
//         break;
//       }
//     }
//   }else{
//     showToast("钱包初始化中");
//     return;
//   }
//
//   // 没有进入break
//   if(needAmount<=sendAmount){
//     showToast("余额不足");
//     return;
//   }
//
//
//   // utxoNeedList=getNeedUtxoList(sendAmount,utxoList,feeVb)
//
//
//
//
//
//   if(myWallet.btcPath=="m/84'/0'/0'/0/0"){
//
//
//
//   }else{
//     final seed = bip39.mnemonicToSeed(myWallet.mnemonic);
//     final node = bip32.BIP32.fromSeed(seed);
//     //1.设置input 和 out put
//     var alice = ECPair.fromWIF(node.toWIF());
//
//
//
//     var calTxb = TransactionBuilder();
//     for(int i=0; i<utxoNeedList.length;i++){
//       Utxo o=utxoNeedList[i];
//       String inputVout=o!.vout!.toString();
//       calTxb.addInput(o.txId,int.parse(inputVout));
//       calTxb.sign(vin: i, keyPair: alice);
//     }
//
//     calTxb.addOutput(sendAddress, sendAmount);
//     calTxb.addOutput(changeAddress, changeSize);
//
//     //计算体积
//     Transaction transactionCal=calTxb.buildIncomplete();
//     int vbSize=transactionCal.virtualSize();
//     print("一次计算体积大小: ${vbSize}");
//
//     // 计算手续费
//     int feed=vbSize * feeVb;
//     print("一次计算手续费: ${feed}");
//
//     changeSize=needAmount-sendAmount-feed;
//     print("一次计算找零金额 : ${changeSize}");
//
//
//
//     if(changeSize<546){
//       int allAmount=needAmount+feed+546;
//       utxoNeedList=getNeedUtxoList(allAmount, utxoList);
//
//       if(needAmount<allAmount){
//         showToast("content");
//         return;
//       }
//
//       var calTxb = TransactionBuilder();
//       for(int i=0; i<utxoNeedList.length;i++){
//         Utxo o=utxoNeedList[i];
//         String inputVout=o!.vout!.toString();
//         calTxb.addInput(o.txId,int.parse(inputVout));
//         calTxb.sign(vin: i, keyPair: alice);
//       }
//
//       calTxb.addOutput(sendAddress, sendAmount);
//       calTxb.addOutput(changeAddress, 546);
//
//       //计算体积
//       Transaction transactionCal=calTxb.buildIncomplete();
//       vbSize=transactionCal.virtualSize();
//       print("二次计算体积大小: ${vbSize}");
//
//
//       // 计算手续费
//       feed=vbSize * feeVb;
//       print("一次计算手续费: ${feed}");
//
//
//       changeSize=needAmount-sendAmount-feed;
//       print("二次实际找零金额：$changeSize");
//
//
//
//
//     }
//
//
//
//   }
//
// }
