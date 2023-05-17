// ignore_for_file: no_logic_in_create_state

import 'dart:ffi';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import '../utils/EventBusUtils.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';
import 'ScanPage.dart';

class ScanResultPage extends StatefulWidget {
  final String result;
  bool isScan;


   ScanResultPage({Key? key, required this.result,required this.isScan}) : super(key: key);

  @override
  State<ScanResultPage> createState() => _SettingsPageState(result);
}

class _SettingsPageState extends State<ScanResultPage> {
  final String sResult;

  _SettingsPageState(this.sResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        // child: Column(
        //   children: [
        //     TitleBack2(
        //       "Send",
        //       onPressed: () {
        //         // Navigator.pushAndRemoveUntil(context,
        //         //     CupertinoPageRoute(builder: (BuildContext context) {
        //         //       return const HomePage();
        //         //     }), (route) => true);
        //
        //         Navigator.of(context)
        //           ..pop()
        //           ..pop();
        //
        //         // if(widget.isScan){
        //         //   // double 次返回
        //         //   Navigator.of(context)
        //         //     ..pop()
        //         //     ..pop();
        //         // }else{
        //         //   Navigator.of(context)
        //         //     .pop();
        //         // }
        //         //事件总线的使用
        //         // EventBusUtils.instance.fire(StringContentEvent(sResult));
        //       },
        //     ),
        //     ScanResultContent(
        //       lastResult: sResult,
        //     )
        //   ],
        // ),
        //响应物理按键
        child: WillPopScope(
          onWillPop: () async {
            // Navigator.pushAndRemoveUntil(context,
            //     CupertinoPageRoute(builder: (BuildContext context) {
            //   return const HomePage();
            // }), (route) => false);

            if(widget.isScan){
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    }else{
                      Navigator.of(context)
                        .pop();
                    }
            return false;
          },
          child: Column(
            children: [
              TitleBack2(
                "Send",
                onPressed: () {
                  if(widget.isScan){
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  }else{
                    Navigator.of(context)
                        .pop();
                  }
                },
              ),
              ScanResultContent(
                lastResult: sResult,
              )
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
  int colors = 0x80171AFF;

  TextEditingController amountController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  ScanResultContent({Key? key, required this.lastResult}) : super(key: key) {
    addressController =
        TextEditingController.fromValue(TextEditingValue(text: lastResult));
    amountController =
        TextEditingController.fromValue(TextEditingValue(text: "0"));
  }

  @override
  State<ScanResultContent> createState() => _ScanResultContentState();
}

class _ScanResultContentState extends State<ScanResultContent> {
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
            widget.colors = 0x80171AFF;
          }
        } else {
          // showToast("333333");
          widget.isOK = false;
          widget.colors = 0x80171AFF;
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
          widget.colors = 0x80171AFF;
        }
      });
    });
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
                        "images/icon.png",
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
                                    "Balances",
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
                                children:  [
                                  Text(spaceBalance,
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
                    child:   Center(
                    child:  TextField(
                        decoration: const InputDecoration(
                            hintText: "Please enter the transfer address",
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
                  ),),
                  // Image.asset("images/mvc_scan_icon.png",
                  //     width: 20, height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return const ScanPage();
                      }));
                    },
                    child: Image.asset("images/mvc_scan_icon.png",
                        width: 20, height: 20),
                  ),
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
                  image:
                  DecorationImage(image: AssetImage("images/input.png"),fit: BoxFit.fill)),
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
                  const Text("Space"),
                  const SizedBox(width: 10)
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 44,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    send(widget.addressController.text,widget.amountController.text);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                      return Color(widget.colors);
                    }),
                  ),
                  child: const Text("Send", style: TextStyle(fontSize: 16))),
            )
          ],
        ));
  }


  void send(String address,String amount){
    double sendAmount=double.parse(amount)*100000000;
    var valueRe = Decimal.parse(sendAmount.toString()).toStringAsFixed(0);
    print("address $address");
    print("sendAmount $valueRe");
    webViewController.runJavaScript("send('$address','$valueRe')");
  }


}
