import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/ScanPage.dart';
import 'package:mvcwallet/page/ScanResultPage.dart';
import 'package:mvcwallet/page/SendAndResultPage.dart';
import 'package:mvcwallet/page/SendPage.dart';
import 'package:mvcwallet/page/SettingsPage.dart';
import 'package:mvcwallet/page/SimpleDialog.dart';
import 'package:mvcwallet/page/TransRecordPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/EventBusUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController webViewController= WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(NavigationDelegate(
      onPageFinished: (ulr) async {
//获取 cookie  信息
// var cookie = await _webViewController
//     .runJavaScriptReturningResult('document.cookie') as String;
// print(cookie);
// showToast("触发页面加载完成");
//执行加载JS 操作
// "消息来至flutter 调用 JS"
// _webViewController.(
//     "flutterCallJsMethod('message from Flutter!')");
// _webViewController.runJavaScript("initMetaWallet(‘消息来至flutter 调用 JS 的传入参数’)");
      }
  ))
  ..addJavaScriptChannel("metaInitCallBack", onMessageReceived: (message){
    showToast("接收 JS 返回的信息是 "+message.message);
// _webViewController.runJavaScriptReturningResult("initMetaWallet('消息来至flutter 调用 JS 的传入参数')").then((value) =>   showToast(value.toString()));
//     webViewController.runJavaScript("initMetaWallet('消息来至flutter 调用 JS 的传入参数')");
  })
  ..addJavaScriptChannel("flutterControl", onMessageReceived: (message){
    showToast("接收 JS: "+message.message);
// _webViewController.runJavaScriptReturningResult("initMetaWallet('消息来至flutter 调用 JS 的传入参数')").then((value) =>   showToast(value.toString()));
  });


void main() {
  runApp(const MyApp());
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      // home: const SettingsPage(),
      // home: const TransRecordPage(),
      // home: const RequestPage(),
      home: const HomePage(),
    );
  }


}

class HomePage extends StatefulWidget {
  final String homeAddress = "21347.32 Spacessss";

  const HomePage({Key? key, homeAddress = "simp"}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(homeAddress);

}

class _HomePageState extends State<HomePage> {
  String addres;







  _HomePageState(this.addres);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return  MyWalletDialog(onConfirm: (){
                          // showToast("确定");
                          Navigator.of(context).pop();
                          // String editMnem = "surround off omit layer raise spoon mail ill priority virtual jazz glass";
                          String editMnem = "record another crane cart oil steel paper friend boss forget repair monitor";
                          String mne = "m/44'/10001'/0'/0/0";
                          // webViewController.runJavaScript("initMetaWallet($editMnem, $mne)");
                          webViewController.runJavaScript("initMetaWallet('$editMnem')");
                          // webViewController.runJavaScript("$editMnem,'m/44'/236'/0'/0/0'");
                          // webViewController.runJavaScript("$editMnem,'m/44'/236'/0'/0/0'");
                          
                        },isVisibility: true);
                      });
                },
                child: Row(
                  children: [
                    const Text(
                      "Wallet1",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(SimColor.deaful_txt_color)),
                    ),
                    const SizedBox(width: 5),
                    Image.asset("images/mvc_wallet_more_icon.png",
                        width: 10, height: 10)
                  ],
                )),
            const Expanded(flex: 1, child: Text("")),
            SizedBox(
              width: 44,
              height: 44,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      // return  ScanPage2();
                      return const ScanPage();
                    }));

                    // EventBusUtils.instance
                    //     .on<StringContentEvent>()
                    //     .listen((event) {
                    //   print(event.str);
                    //   setState(() {
                    //     addres=event.str;
                    //   });
                    // });
                  },
                  child: Image.asset("images/mvc_scan_icon.png",
                      width: 22, height: 22)),
            ),
            SizedBox(
                width: 44,
                height: 44,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return const TransRecordPage();
                      }));
                    },
                    child: Image.asset("images/mvc_record_icon.png",
                        width: 22, height: 22))),
            SizedBox(
              height: 44,
              width: 44,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return const SettingsPage();
                      // return const RequestPage();
                    }));
                  },
                  child: Image.asset("images/mvc_more_icon.png",
                      width: 22, height: 22)),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: const BoxDecoration(
// color: Colors.red,
                  image: DecorationImage(
                image: AssetImage("images/bg_img_space.png"),
              )
// image: AssetImage("images/icon.png"),)
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Balance",
                    style: TextStyle(
                        color: Color(SimColor.deaful_txt_half_color),
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ), //SimColor.deaful_txt_color
                  const Text(
                    "\$34,201.25",
                    style: TextStyle(
                        color: Color(SimColor.deaful_txt_color), fontSize: 40),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/icon.png",
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        // "21347.32 Spacessss",
                        addres,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
//这里是两个 Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
//这里写2个 Button
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                return const RequestPage();
                              }));
                              //   Navigator.of(context).push(CupertinoPageRoute(
                              //     builder: (BuildContext context) {
                              //   return const SimWebView();
                              // }));

                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(SimColor.deaful_txt_color))),
                            child: const Text("Request",
                                style: TextStyle(fontSize: 16))),
                      )),
                  const SizedBox(width: 20),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                                Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                                return const ScanResultPage(result: "");
                              }
                              ));
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return  const ProgressDialog();
                              //     });

                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(SimColor.color_button_blue))),
                            child: const Text("Send",
                                style: TextStyle(fontSize: 16)),
                          )))
                ],
              ),
            ),
             SimWebView(webViewController)
          ],
        ),
      ),
    );
  }




}
