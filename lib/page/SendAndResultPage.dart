
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/Constants.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';
import 'RequestPage.dart';
import 'ScanPage.dart';

class SendAndResultPage extends StatefulWidget {
  const SendAndResultPage({Key? key}) : super(key: key);

  @override
  State<SendAndResultPage> createState() => _SendAndResultPageState();
}

class _SendAndResultPageState extends State<SendAndResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        //响应物理按键
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushAndRemoveUntil(context,
                CupertinoPageRoute(builder: (BuildContext context) {
                  return const HomePage();
                }), (route) => false);
            return false;
          },
          child: Column(
            children: [
              TitleBack2(
                "Send",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (BuildContext context) {
                        return const HomePage();
                      }), (route) => false);
                  // double 次返回
                  // Navigator.of(context)
                  //   ..pop()
                  //   ..pop();
                  //事件总线的使用
                  // EventBusUtils.instance.fire(StringContentEvent(sResult));
                },
              ),
              const ScanResultContent(),
            ],
          ),
        ),
      ),
    );
  }
}


class ScanResultContent extends StatefulWidget {
  const ScanResultContent({Key? key}) : super(key: key);

  @override
  State<ScanResultContent> createState() => _ScanResultContentState();
}

class _ScanResultContentState extends State<ScanResultContent> {
  @override
  Widget build(BuildContext context) {
    return  Padding( padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
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
                              children: const [
                                Text("3234.485u89 Space",
                                    style: TextStyle(
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
                  child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
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
                      // controller: widget.addressController,
                    ),
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
        ],
      ),
    );
  }


  send(){
    webViewController.runJavaScript("initMetaWallet('Send 发送交易')");
  }

}

