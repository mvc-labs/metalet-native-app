import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvcwallet/bean/RateResponse.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/dialog/MyWalletDialog.dart';
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

Wallet myWallet = Wallet("", "", "", "0.0", "0","Wallet");
int selectIndex = 0;
int id = 0;
String wallets = "";
var timeCount = 5;
String spaceBalance = "0.0 Space";
String walletBalance = "\$ 0.0";
List myWalletList = [];
bool isUst = true;
bool isShowLoadingDialog = false;
bool isAddWallet = false;
bool isLogin=false;
// BuildContext? context;
final navKey = GlobalKey<NavigatorState>();


WebViewController webViewController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..addJavaScriptChannel("metaInitCallBack", onMessageReceived: (message) {
    showToast(" JS " + message.message);

    if (isShowLoadingDialog) {
      isShowLoadingDialog = false;
      Navigator.of(navKey.currentState!.overlay!.context).pop();
    }

    if (isNoEmpty(message.message)) {
      myWallet = Wallet.fromJson(json.decode(message.message));
      print("钱包助记词：" +
          myWallet.mnemonic +
          "  余额 ： " +
          myWallet.balance +
          "  地址：  " +
          myWallet.address+
          "名称： "+
          myWallet.name
      );
      if (isAddWallet) {
        isLogin=true;
        isAddWallet = false;
        id = int.parse(myWallet.id);
        SharedPreferencesUtils.setValue("id_key", id);
        myWalletList.add(myWallet);
        String cacheWallet = json.encode(myWalletList);
        SharedPreferencesUtils.setValue("mvc_wallet", cacheWallet);
        SharedPreferencesUtils.getString("mvc_wallet", "")
            .then((value) => print("添加钱包成功： " + value.toString()));
      }
    }
  })
  ..addJavaScriptChannel("flutterControl", onMessageReceived: (message) {
    showToast(" JS : " + message.message);
  })
  ..addJavaScriptChannel("metaBalance", onMessageReceived: (message) {
    showToast("Back balance : " + message.message);
    if(isLogin){
      webViewController.runJavaScript("getBalance()");
      dioRate(message.message);
    }
  })
  ..addJavaScriptChannel("metaSend", onMessageReceived: (message){
    print("Trans${message.message}");
    showToast(message.message);
  });

void main() {
  runApp(const MyApp());
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  // Timer.periodic(const Duration(seconds: 1), (timer) {
  //   timeCount -= 1;
  //
  //   if (timeCount <= 0) {
  //     SharedPreferencesUtils.getString("mvc_wallet", "")
  //         .then((value) => print("获取报错的钱包： " + value.toString()));
  //
  //     SharedPreferencesUtils.getString("mvc_wallet", "").then((value) {
  //       wallets = value;
  //       SharedPreferencesUtils.getInt("id_key", id)
  //           .then((value) {
  //         id = value;
  //         SharedPreferencesUtils.getInt("selectIndex_key",selectIndex).then((value){
  //           selectIndex=value;
  //           if (wallets.isNotEmpty) {
  //             myWalletList = json.decode(wallets);
  //             print("当前的 selectInde$selectIndex");
  //             print("解析的数组是："+myWalletList.toString());
  //
  //             myWallet = Wallet.fromJson(myWalletList[selectIndex]);
  //             String editMnem = myWallet.mnemonic;
  //             String mne = myWallet.path;
  //             var seInt = id.toString();
  //             webViewController
  //                 .runJavaScript("initMetaWallet('$editMnem','$mne','$seInt')");
  //           } else {
  //             print("获取的缓存钱包为空");
  //           }
  //         });
  //
  //       });
  //     });
  //     // String editMnem = "net turn first rare glide patient mask hungry damp cabbage umbrella ostrich";
  //     // String mne = "236";
  //     timer.cancel();
  //   }
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      theme: ThemeData(primaryColor: Colors.white),
      // home: const SettingsPage(),
      // home: const TransRecordPage(),
      // home: const RequestPage(),
      home: HomePage(mContext: context),
    );
  }
}

class HomePage extends StatefulWidget {
  final String homeAddress = "21347.32 Spacessss";
  final BuildContext? mContext;

  const HomePage({Key? key, homeAddress = "simp", this.mContext})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(homeAddress);
}

class _HomePageState extends State<HomePage> implements Indo {
  String addres;

  _HomePageState(this.addres);

  @override
  void initState() {
    // TODO: implement initState
    EventBusUtils.instance.on<WalletHomeData>().listen((event) {
      // print(event.);
      setState(() {
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        spaceBalance = event.spaceBalance;
        walletBalance = event.walletBalance;
        print("收到更新 $spaceBalance");
      });
    });

    EventBusUtils.instance.on<DeleteWallet>().listen((event) {
      // print(event.);
      setState(() {
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        isLogin=false;
        spaceBalance ="0.0 Space";
        walletBalance =  "\$ 0.0";
      });
    });


    setState(() {
      initLocalWallet();
    });

    super.initState();
  }

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
                        // return MyWalletDialog(
                        //     onConfirm: () {
                        //       // showToast("确定");
                        //       Navigator.of(context).pop();
                        //       // String editMnem = "surround off omit layer raise spoon mail ill priority virtual jazz glass";
                        //       // String editMnem = "record another crane cart oil steel paper friend boss forget repair monitor";
                        //       String editMnem = "net turn first rare glide patient mask hungry damp cabbage umbrella ostrich";
                        //       String mne = "236";
                        //       webViewController.runJavaScript("initMetaWallet('$editMnem','$mne')");
                        //       webViewController.runJavaScript("getBalance()");
                        //       // webViewController.runJavaScript("$editMnem,'m/44'/236'/0'/0/0'");
                        //       // webViewController.runJavaScript("$editMnem,'m/44'/236'/0'/0/0'");
                        //     },
                        //     isVisibility: true);
                        //
                        // EventBusUtils.instance
                        //     .on<WalletHomeData>()
                        //     .listen((event) {
                        //   // print(event.);
                        //   setState(() {
                        //     spaceBalance=event.spaceBalance;
                        //     walletBalance=event.walletBalance;
                        //   });
                        // });
                        return MyWalletDialog(indo: this, isVisibility: true);
                      });
                },
                child: Row(
                  children: [
                     Text(
                      myWallet.name,
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
                    if(isLogin){
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                            // return  ScanPage2();
                            return const ScanPage();
                          }));
                    }else{
                      hasNoLogin(this);
                    }
                  },
                  child: Image.asset("images/mvc_scan_icon.png",
                      width: 22, height: 22)),
            ),
            SizedBox(
                width: 44,
                height: 44,
                child: TextButton(
                    onPressed: () {
                      if(isLogin){
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (BuildContext context) {
                              return const TransRecordPage();
                            }));
                      }else{
                        hasNoLogin(this);
                      }
                    },
                    child: Image.asset("images/mvc_record_icon.png",
                        width: 22, height: 22))),
            SizedBox(
              height: 44,
              width: 44,
              child: TextButton(
                  onPressed: () {

                    if(isLogin){
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                            return const SettingsPage();
                            // return const RequestPage();
                          }));
                    }else{
                      hasNoLogin(this);
                    }


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
                  Text(
                    walletBalance,
                    style: const TextStyle(
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
                        spaceBalance,
                        style: const TextStyle(fontSize: 17),
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

                              if(isLogin){
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                      return const RequestPage();
                                    }));
                              }else{
                                hasNoLogin(this);
                              }



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
                              if(isLogin){
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                      return ScanResultPage(
                                        result: "",
                                        isScan: false,
                                      );
                                    }));
                              }else{
                                hasNoLogin(this);
                              }
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
            // Visibility(
            //   visible: false,
            //   child: SizedBox(
            //     width: 100,
            //     height: 100,
            //     child: WebViewWidget(
            //         controller: webViewController
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  @override
  void addWallet(String walletName, String mnemoni, String path) {
    // TODO: implement addWallet
    showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(isShow: true);
        });
    isShowLoadingDialog = true;
    isAddWallet = true;


    var id = Random().nextInt(100000000).toString();
    webViewController.runJavaScript("initMetaWallet('$mnemoni','$path','$id','$walletName')");
  }
}

void dioRate(String message) async {
  final dio = Dio();
  final response = await dio
      .get("https://api.microvisionchain.com/metaid-base/v1/exchange/rates");
  var myWalletBalance = (double.parse(message) / 100000000).toStringAsFixed(8);
  var myWalletBalanceShow = "$myWalletBalance Space";
  if (response.statusCode == HttpStatus.OK) {
    // RateResponse data=json.decode(response.data.toString());
    // print(data.result!.rates![0]);
    // Map<String, dynamic> map =jsonDecode(response.data);
    RateResponse data = RateResponse.fromJson(response.data);
    print("get data ：" + data.toString());
    String? cnyPrice;
    String? ustPrice;

    for (var o in data.result!.rates!) {
      if (o.symbol == "mvc") {
        cnyPrice = o.price!.cny;
        ustPrice = o.price!.usd;
        print("mvc Price： ${o.price!.cny}");
        print("当前的mvc价格是\$： ${o.price!.usd}");
        String? price = o.price!.cny;
        print(price);
      }
    }
    print(data.result!.rates![0].price!.cny);
    var value = double.parse(message) / 100000000;

    if (isUst && isNoEmpty(ustPrice)) {
      double mySpace = double.parse(ustPrice!);
      walletBalance = "\$ ${(value * mySpace).toStringAsFixed(2)}";
    } else {
      double mySpace = double.parse(cnyPrice!);
      walletBalance = "¥ ${(value * mySpace).toStringAsFixed(2)}";
    }
    EventBusUtils.instance
        .fire(WalletHomeData(myWalletBalanceShow, walletBalance));
  } else {
    EventBusUtils.instance
        .fire(WalletHomeData(myWalletBalanceShow, walletBalance));
  }
}
