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
import 'package:mvcwallet/bean/CheckVersion.dart';
import 'package:mvcwallet/bean/RateResponse.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/dialog/MyWalletDialog.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/ScanPage.dart';
import 'package:mvcwallet/page/ScanResultPage.dart';
import 'package:mvcwallet/page/SettingsPage.dart';
import 'package:mvcwallet/page/SimpleDialog.dart';
import 'package:mvcwallet/page/TransRecordPage.dart';
import 'package:mvcwallet/sqlite/SqWallet.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/EventBusUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bean/Update.dart';
// "Use of this wallet is at your own risk and discretion.The wallet is not liable for any losses incurred as a result of using the wallet. ",

Wallet myWallet = Wallet("", "", "", "0.0", "0", "Wallet",0);
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
bool isSwitchWallet = false;
bool   isLogin = false;
bool isCreate = false;
// BuildContext? context;
final navKey = GlobalKey<NavigatorState>();
String success = "Success";
String error = "error";
String walletName = "Wallet";
bool isSendFinish = false;
Timer? balanceTimer;
String createWalletPath="10001";
bool isFingerCan = true;
bool isNoGopay=false;
String versionName="";
String versionCode="";



WebViewController webViewController = WebViewController();

// by now main
void main() {


  // ios pull
  runApp(const MyApp());
  if (Platform.isAndroid) {
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
      navigatorKey: navKey,
      theme: ThemeData(primaryColor: Colors.white),
      // home: const SettingsPage(),
      // home: const TransRecordPage(),
      // home: const RequestPage(),
      // home: HomePage(mContext: context),
      home: const DefaultWidget(),
    );
  }
}


class DefaultWidget extends StatefulWidget {

  const DefaultWidget({Key? key}) : super(key: key);

  @override
  State<DefaultWidget> createState() => _DefaultWidgetState();

}

class _DefaultWidgetState extends State<DefaultWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferencesUtils.getBool("key_finger",false).then((value){
      setState(() {
        isFingerCan=value;
        print("change $isFingerCan");
        if(isFingerCan){
          authenticateMe().then((value) {
            if(value){
              Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (BuildContext context){
                return  HomePage(mContext: context);
              }), (route) => false);
            }else{
              exit(0);
            }
          });
        }else{
          Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (BuildContext context){
            return  HomePage(mContext: context);
          }), (route) => false);
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // if(isFingerCan){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
// color: Colors.red,
              image: DecorationImage(
                image: AssetImage("images/bg_img_space.png"),
              )
// image: AssetImage("images/icon.png"),)
          ),
        ),
      );
    // }else{
    //   return  HomePage(mContext: context);
    // }
  }
}




class HomePage extends StatefulWidget {
  final BuildContext? mContext;

  const HomePage({Key? key, homeAddress = "simp", this.mContext})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements Indo {
  _HomePageState();

  @override
  void initState() {
    // TODO: implement initState
    EventBusUtils.instance.on<WalletHomeData>().listen((event) {
      // print(event.);
      setState(() {
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        spaceBalance = event!.spaceBalance;
        walletBalance = event!.walletBalance;
      });
    });

    EventBusUtils.instance.on<DeleteWallet>().listen((event) {
      // print(event.);
      setState(() {
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        isLogin = false;
        spaceBalance = "0.0 Space";
        walletBalance = "\$ 0.0";
        walletName="Wallet";
        print("11111");
        SqWallet sqWallet = SqWallet();
        Future<List<Wallet>> list = sqWallet.getAllWallet();
        list.then((value) {
          setState(() {
            if (value.isNotEmpty) {
              print("22222");
              Wallet vWallet=value[0];
              vWallet.isChoose=1;
              myWallet = vWallet;
              isLogin = true;
              walletName=myWallet.name;
              print("44444"+myWallet.balance);
              dioRate(myWallet.balance);
              sqWallet.updateDefaultData(myWallet);
              switchWallet(myWallet);

            } else {
              print("33333");
              isLogin = false;
              spaceBalance = "0.0 Space";
              walletBalance = "\$ 0.0";
              walletName="Wallet";
            }
          });
        });
      });
    });

    setState(() {
      // initLocalWallet();
      // initLocalWalletBySql();

      SqWallet sqWallet = SqWallet();
      Future<List<Wallet>> list = sqWallet.getAllWallet();
      list.then((value) {
        if (value.isNotEmpty) {
          for (var wallet in value) {
            // ignore: unrelated_type_equality_checks
            if(wallet.isChoose==1){
               myWallet = wallet;
               isLogin = true;
               walletName=myWallet.name;
               dioRate(myWallet.balance);
            }
          }
        } else {
          print("Wallet Null");
        }
      });
      SharedPreferencesUtils.getBool("isUst_key", true)
          .then((value) => isUst = value);

      Timer.periodic(const Duration(seconds: 1), (timer) {
        timeCount -= 1;
        if (timeCount <= 0) {
          String editMnem = myWallet.mnemonic;
          String mne = myWallet.path;
          var seInt = id.toString();
          if (mne.isNotEmpty) {
            webViewController.runJavaScript(
                "initMetaWallet('$editMnem','$mne','$seInt','${myWallet.name}')");
          }
          timer.cancel();
        }
      });
    });

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("metaInitCallBack", onMessageReceived: (message) {
        if (isShowLoadingDialog) {
          isShowLoadingDialog = false;
          Navigator.of(navKey.currentState!.overlay!.context).pop();
        }
        if (isNoEmpty(message.message)) {
          myWallet = Wallet.fromJson(json.decode(message.message));


          print("：${myWallet.mnemonic}");
          if (isAddWallet) {
            id = int.parse(myWallet.id);
            SharedPreferencesUtils.setValue("id_key", id);
            myWalletList.add(myWallet);
            String cacheWallet = json.encode(myWalletList);
            SharedPreferencesUtils.setValue("mvc_wallet", cacheWallet);


            showToast(success);
            isLogin = true;
            setState(() {
              walletName=myWallet.name;
              dioRate(myWallet.balance);
            });
            SqWallet sqWallet = SqWallet();
            if(isSwitchWallet==false){
              bool isInset=true;
              sqWallet.refreshDefaultData(isInset,myWallet);
            }else{
              isSwitchWallet=false;
              sqWallet.updateDefaultData(myWallet);
            }
            isAddWallet = false;
            if(balanceTimer!=null){
              balanceTimer!.cancel();
              balanceTimer=null;
            }

            Future<List<Wallet>> list = sqWallet.getAllWallet();
            list.then((value) {
              if (value.isNotEmpty) {
              } else {
                print("Wallet Null");
              }
            });


            // sqWallet.id=myWallet.id;
            // sqWallet.name=myWallet.name;
            // sqWallet.mnemonic=myWallet.mnemonic;
            // sqWallet.path=myWallet.path;
            // sqWallet.address=myWallet.address;
            // sqWallet.balance=myWallet.balance;
          }
        } else {
          // initMetaWallet
          showToast("Failed to initialize wallet Please check mnemonics");
        }
      })
      ..addJavaScriptChannel("flutterControl", onMessageReceived: (message) {
        showToast(" JS : " + message.message);
      })
      ..addJavaScriptChannel("metaBalance", onMessageReceived: (message) {

        SqWallet sqWallet = SqWallet();
        myWallet.balance=message.message;
        sqWallet.update(myWallet);

        getBalanceTimer();
        dioRate(message.message);
      })
      ..addJavaScriptChannel("metaSend", onMessageReceived: (message) {
        isSendFinish = true;
        if (message.message.isNotEmpty) {
          showToast(success);
          Navigator.of(navKey.currentState!.overlay!.context)
            ..pop()
            ..pop();
        } else {
          showToast(error);
        }
      })
      ..addJavaScriptChannel("metaCreateWallet",
          onMessageReceived: (onMessageReceived) {
        print(onMessageReceived.message);
        // String mne="silk elder badge keep crew reject such person orange clock rural argue";
        String mne = onMessageReceived.message;

        if (mne.isNotEmpty) {
          //SimCreate
          addWallet(walletName, mne, createWalletPath);
        } else {
          showToast(error);
        }
      })
      ..setNavigationDelegate(NavigationDelegate(
          onWebResourceError: (error) {}, onPageStarted: (url) {}));



    //check Version
    SharedPreferencesUtils.getBool("ask_key",true).then((value) {
      if(value){
        doCheckVersion(context);
      }
    });

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return CreateWalletDialog(indo: this);
    //     });

    initVersion();

    super.initState();
  }


  getBalanceTimer(){
    balanceTimer ??= Timer.periodic(const Duration(seconds: 5), (timer) {
        // timeCount -= 1;
        if(isLogin){
          // if (timeCount <= 0) {
          //   timeCount = 5;
          webViewController.runJavaScript("getBalance()");
          // dioRate(message);
          // }
        } else{
          timer.cancel();
        }
      });
  }





  @override
  Widget build(BuildContext context) {
    // authenticateMe().then((value) {
    //   bool auth=value;
    //
    // });
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
                    SqWallet sqWallet=SqWallet();
                    sqWallet.getAllWallet().then((value) {
                      if(value.isNotEmpty){
                        showDialog(context: context, builder: (context){
                          return MyWalletsDialog(indo: this,walletList: value,);
                        });

                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return MyWalletListDialog(indo: this,isVisibility: true,walletList: value,);
                        //     });
                      }else{
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return CreateWalletDialog(indo: this);
                        //     });
                        hasNoLogin(this);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        walletName,
                        style: const TextStyle(
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
                      if (isLogin) {
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (BuildContext context) {
                              // return  ScanPage2();
                              return const ScanPage();
                            }));
                      } else {
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
                        if (isLogin) {
                          Navigator.of(context).push(
                              CupertinoPageRoute(builder: (BuildContext context) {
                                return const TransRecordPage();
                              }));
                        } else {
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
                      if (isLogin) {
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (BuildContext context) {
                              return const SettingsPage();
                              // return const RequestPage();
                            }));
                      } else {
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
                          width: 30,
                          height: 30,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                              onPressed: () {
                                if (isLogin) {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                        return const RequestPage();
                                      }));
                                } else {
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
                                if (isLogin) {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                        return ScanResultPage(
                                          result: "",
                                          isScan: false,
                                        );
                                      }));
                                } else {
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
    webViewController.runJavaScript(
        "initMetaWallet('$mnemoni','$path','$id','$walletName')");
  }

  @override
  void createWallet(String name,String path) {
    webViewController.runJavaScript("generateMnemonic()");
    setState(() {
      walletName=name;
      createWalletPath=path;
    });
  }

  @override
  void switchWallet(Wallet? wallet) {
    if(wallet!=null){
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(isShow: true);
        });
    isShowLoadingDialog = true;
    isAddWallet = true;
    isSwitchWallet=true;
    webViewController.runJavaScript(
        "initMetaWallet('${wallet.mnemonic}','${wallet.path}','${wallet.id}','${wallet.name}')");
    }
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
    // print("get data ：" + response.data.toString());
    String? cnyPrice;
    String? ustPrice;

    for (var o in data.result!.rates!) {
      if (o.symbol == "mvc") {
        cnyPrice = o.price!.cny;
        ustPrice = o.price!.usd;
        // print("mvc Price： ${o.price!.cny}");
        // print("mvc \$： ${o.price!.usd}");
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
