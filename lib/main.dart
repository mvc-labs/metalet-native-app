import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvcwallet/bean/CheckVersion.dart';
import 'package:mvcwallet/bean/NftSendBack.dart';
import 'package:mvcwallet/bean/RateResponse.dart';
import 'package:mvcwallet/bean/btc/BtcBalanceV3Response.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/dialog/MyWalletDialog.dart';
import 'package:mvcwallet/page/FirstSelectNetworkPage.dart';
import 'package:mvcwallet/page/MainBTCPage.dart';
import 'package:mvcwallet/page/MainSpacePage.dart';
import 'package:mvcwallet/page/NftPage.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/ScanPage.dart';
import 'package:mvcwallet/page/ScanResultPage.dart';
import 'package:mvcwallet/page/SettingsPage.dart';
import 'package:mvcwallet/page/ShowBackUpMnePage.dart';
import 'package:mvcwallet/page/SimpleDialog.dart';
import 'package:mvcwallet/page/TokenPage.dart';
import 'package:mvcwallet/page/TransBtcRecordPage.dart';
import 'package:mvcwallet/page/TransRecordPage.dart';
import 'package:mvcwallet/sqlite/SqWallet.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/EventBusUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart' hide Wallet;

import 'bean/BtcBalanceResponse.dart';
import 'bean/BtcFeeBean.dart';
import 'bean/MetaLetRate.dart';
import 'bean/Update.dart';
import 'btc/CommonUtils.dart';
import 'constant/SimContants.dart';
// "Use of this wallet is at your own risk and discretion.The wallet is not liable for any losses incurred as a result of using the wallet. ",
//wallet data
Wallet myWallet = Wallet("", "", "", "0.0", "0", "Wallet", 0, "", "", "");
int selectIndex = 0;
int id = 0;
String wallets = "";
var timeCount = 5;
String spaceBalance = "0.0 Space";
String walletBalance = "\$ 0.0";
String btcBalance = "0.00 BTC";
String btcWalletBalance = "\$ 0.0";
String btype = "space";
int index = 0;

List myWalletList = [];
bool isUst = true;
bool isShowLoadingDialog = false;
bool isAddWallet = false;
bool isSwitchWallet = false;
bool isLogin = false;
bool isCreate = false;
// BuildContext? context;
final navKey = GlobalKey<NavigatorState>();
String success = "Success";
String error = "error";
String walletName = "Wallet";
bool isSendFinish = false;
Timer? balanceTimer;
String createWalletPath = "10001";
String createWalletBtcPath = "m/44'/10001'/0'/0/0";
bool isFingerCan = true;
bool isNoGopay = false;
String versionName = "";
String versionCode = "";
bool isFore = true;
NftSendBack nftSendBack = NftSendBack();
SendNftDialogData sendNftDialogData = SendNftDialogData();
SendFtDialogData sendFtDialogData = SendFtDialogData();

WebViewController webViewController = WebViewController();


//wallet settings
int walletMode = 0; //space && btc  1/btc 2/space
bool isHomePage = true;
bool isFirstUse=true;


String selectWalletName = "BTC/SPACE";
final List<String> modeNameList = [
  "BTC/SPACE",
  "BTC",
  "SPACE"
  // "m/49'/0'/0'/0/0",
  // "m/86'/0'/0'/0/0"
];

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
      builder: (context, child) {
        return GestureDetector(
          // 全局添加点击空白处隐藏键盘
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
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

      SharedPreferencesUtils.getInt("walletMode_key", 0).then((value) {
       walletMode=value;
       setState(() {
        if (walletMode == 0) {
          walletMode = 0;
          selectWalletName="BTC/SPACE";
        } else if (walletMode == 1) {
          walletMode = 1;
          selectWalletName="BTC";
        } else if (walletMode == 2) {
          walletMode = 2;
          selectWalletName="SPACE";
        }


        SharedPreferencesUtils.getBool("key_finger", false).then((value) {
          setState(() {
            isFingerCan = value;
            print("change $isFingerCan");
            if (isFingerCan) {
              authenticateMe().then((value) {
                if (value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          settings: const RouteSettings(name: "home"),
                          builder: (BuildContext context) {
                            return HomePage(mContext: context);
                            // return HomeTabPage();
                          }),
                          (route) => false);
                } else {
                  exit(0);
                }
              });
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      settings: const RouteSettings(name: "home"),
                      builder: (BuildContext context) {
                        return HomePage(mContext: context);
                        // return HomeTabPage();
                      }),
                      (route) => false);
            }
          });
        });


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

class _HomePageState extends State<HomePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin
    implements Indo {
  late StreamSubscription _subscription_delete;
  late StreamSubscription _subscription_banlace;
  late StreamSubscription _subscription_banlace_btc;
  late StreamSubscription _subscription_btc_utxo;

  late Indo indo;

  _HomePageState();

  final GlobalKey<_HomePageState> _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    indo = this;


    setState(() {
      if (walletMode == 0) {
        walletMode = 0;
        selectWalletName="BTC/SPACE";

        _homeTopTabList.clear();
        _homeTopTabList.add(Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("images/btc_icon.png", width: 20, height: 20),
              const SizedBox(
                width: 5,
              ),
              Text(
                "BTC",
                style: getDefaultTextStyle(),
              )
            ],
          ),
        ),);
        _homeTopTabList.add( Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("images/icon.png", width: 24, height: 24),
              const SizedBox(
                width: 5,
              ),
              Text(
                "SPACE",
                style: getDefaultTextStyle(),
              )
            ],
          ),
        ),);
        tabController = TabController(length: 2, vsync: this);
      } else if (walletMode == 1) {
        walletMode = 1;
        selectWalletName="BTC";
        if(_homeTopTabList.length>1){
          _homeTopTabList.removeAt(1);
        }

        tabController = TabController(length: 1, vsync: this);

      } else if (walletMode == 2) {
        walletMode = 2;
        selectWalletName="SPACE";
        if(_homeTopTabList.length>1){
          _homeTopTabList.removeAt(0);
        }
        tabController = TabController(length: 1, vsync: this);
      }
    });
  /*  SharedPreferencesUtils.getInt("walletMode_key", 0).then((value) {
       walletMode=value;
       setState(() {
        if (walletMode == 0) {
          walletMode = 0;
          selectWalletName="BTC/SPACE";
        } else if (walletMode == 1) {
          walletMode = 1;
          selectWalletName="BTC";
          _homeTopTabList.removeAt(1);
        } else if (walletMode == 2) {
          walletMode = 2;
          selectWalletName="SPACE";
          _homeTopTabList.removeAt(0);
        }
      });
    });
*/

    //brc20 icon
    getBrc20Icon();

    WidgetsBinding.instance?.addObserver(this);
    _subscription_banlace =
        EventBusUtils.instance.on<WalletHomeData>().listen((event) {
      // print(event.);
      setState(() {
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        spaceBalance = event!.spaceBalance;
        walletBalance = event!.walletBalance;
      });
    });

    _subscription_banlace_btc =
        EventBusUtils.instance.on<WalletBTCData>().listen((event) {
      // print(event.);
      setState(() {
        print("轮询获取的btc 信息 btcBalance ： " +
            event!.btcBalance +
            " btcWalletBalance:  " +
            event!.btcWalletBalance);
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        btcBalance = event!.btcBalance;
        btcWalletBalance = event!.btcWalletBalance;
        // getBtcFee();
      });
    });

    _subscription_delete =
        EventBusUtils.instance.on<DeleteWallet>().listen((event) {
      // print(event.);
      setState(() {
        // var value=double.parse(event.spaceBalance)/100000000;
        // spaceBalance="$value Space";
        isLogin = false;
        spaceBalance = "0.0 Space";
        walletBalance = "\$ 0.0";
        walletName = "Wallet";
        print("11111");
        SqWallet sqWallet = SqWallet();
        Future<List<Wallet>> list = sqWallet.getAllWallet();
        list.then((value) {
          setState(() {
            if (value.isNotEmpty) {
              print("22222");
              Wallet vWallet = value[0];
              vWallet.isChoose = 1;
              myWallet = vWallet;
              isLogin = true;
              walletName = myWallet.name;
              print("44444" + myWallet.balance);
              dioRate(myWallet.balance);
              sqWallet.updateDefaultData(myWallet);
              switchWallet(myWallet);
            } else {
              print("33333");
              isLogin = false;
              spaceBalance = "0.0 Space";
              walletBalance = "\$ 0.0";
              walletName = "Wallet";
            }
          });
        });
      });
    });

    _subscription_btc_utxo =
        EventBusUtils.instance.on<WalletBTCUtxo>().listen((event) {
      setState(() {
        print("重新获取一次UTXO：" + jsonEncode(event!.btcUtxoBean!.toJson()));

        btcUtxoBean = event!.btcUtxoBean;
      });
    });

    setState(() {
      // initLocalWallet();
      // initLocalWalletBySql();

      SqWallet sqWallet = SqWallet();
      Future<List<Wallet>> list = sqWallet.getAllWallet();


      list.then((value) {
        if (value.isNotEmpty) {
          isFirstUse=false;
          for (var wallet in value) {
            // ignore: unrelated_type_equality_checks
            if (wallet.isChoose == 1) {
              myWallet = wallet;
              isLogin = true;
              walletName = myWallet.name;
              createWalletBtcPath = myWallet.btcPath;
              dioRate(myWallet.balance);
            }
          }
        } else {
          isFirstUse=true;
          print("Wallet Null");
          Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
            return FirstSelectNetworkPage(indo: indo,);
          }));


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
          SqWallet sqWallet = SqWallet();

          print("：${myWallet.mnemonic}");
          if (isAddWallet) {
            //back up
            if(isFirstUse){
              Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
                return ShowBackUpMnePage(phraseString: myWallet.mnemonic,);
              }));
            }

            id = int.parse(myWallet.id);
            SharedPreferencesUtils.setValue("id_key", id);
            myWalletList.add(myWallet);
            String cacheWallet = json.encode(myWalletList);
            SharedPreferencesUtils.setValue("mvc_wallet", cacheWallet);

            showToast(success);
            isLogin = true;
            setState(() {
              walletName = myWallet.name;
              dioRate(myWallet.balance);
            });

            // if(myWallet.btcAddress.isEmpty){
            initBTCWallet(createWalletBtcPath);
            // }

            if (isSwitchWallet == false) {
              bool isInset = true;
              sqWallet.refreshDefaultData(isInset, myWallet);
            } else {
              isSwitchWallet = false;
              sqWallet.updateDefaultData(myWallet);
            }

            isAddWallet = false;
            if (balanceTimer != null) {
              balanceTimer!.cancel();
              balanceTimer = null;
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
          } else {
            // if(myWallet.btcAddress.isEmpty){
            initBTCWallet(createWalletBtcPath);
            // }
            sqWallet.updateDefaultData(myWallet);
          }

          getBtcUtxo();
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
        myWallet.balance = message.message;
        sqWallet.update(myWallet);

        getBalanceTimer();
        dioRate(message.message);
        getBTCBalance();
        print("获取的余额是： " + message.message);
      })
      ..addJavaScriptChannel("metaSend", onMessageReceived: (message) {
        isSendFinish = true;
        if (message.message.isNotEmpty) {
          showToast(success);
          // Navigator.of(navKey.currentState!.overlay!.context)
          //   ..pop()
          // //   ..pop();
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (BuildContext context) {
          //   return HomePage(mContext: context);
          // }), (route) => false);
          Navigator.popUntil(context, ModalRoute.withName("home"));
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
          addWallet(walletName, mne, createWalletPath, createWalletBtcPath);
        } else {
          showToast(error);
        }
      })
      ..addJavaScriptChannel("metaSendNft",
          onMessageReceived: (onMessageReceived) {
        // p(onMessageReceived.message);
        try {
          nftSendBack =
              NftSendBack.fromJson(json.decode(onMessageReceived.message));
          print(nftSendBack.txid);
          if (nftSendBack.txid!.isNotEmpty) {
            Navigator.popUntil(context, ModalRoute.withName("token"));
            EventBusUtils.instance.fire(SendNftSuccess());

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ShowNftSuccessDialog(
                    nftName: sendNftDialogData.nftName!,
                    nftIconUrl: sendNftDialogData.nftIconUrl!,
                    nftTokenIndex: sendNftDialogData.nftTokenIndex!,
                    receiveAddress: sendNftDialogData.receiveAddress!,
                    transactionID: nftSendBack.txid!,
                  );
                });
          }
        } catch (e) {
          Navigator.of(navKey.currentState!.overlay!.context).pop();
          showToast("Send failed Please check the address");
        }
      })
      ..addJavaScriptChannel("metaSendFt",
          onMessageReceived: (onMessageReceived) {
        // p(onMessageReceived.message);

        try {
          nftSendBack =
              NftSendBack.fromJson(json.decode(onMessageReceived.message));
          print(nftSendBack.txid);
          if (nftSendBack.txid!.isNotEmpty) {
            Navigator.popUntil(context, ModalRoute.withName("token"));
            EventBusUtils.instance.fire(SendFtSuccess());
          }
        } catch (e) {
          Navigator.of(navKey.currentState!.overlay!.context).pop();
          showToast("Send failed Please check the address");
          print(e.toString());
        }
      })
      ..setNavigationDelegate(NavigationDelegate(
          onWebResourceError: (error) {}, onPageStarted: (url) {}));

    if (isNoGopay) {
      //check Version
      SharedPreferencesUtils.getBool("ask_key", true).then((value) {
        if (value) {
          doCheckVersion(context);
        }
      });
    }

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return CreateWalletDialog(indo: this);
    //     });

    initVersion();
    print("_homeTopTabList.length ："+_homeTopTabList.length.toString());
    // tabController = TabController(length: _homeTopTabList.length, vsync: this);

    tabController.addListener(() {
      index = tabController.index;
    });

    // child:  InkWell(
    //   onTap: (){
    //     showToast("1");
    //   },
    //   child: ,
    // ),
    //
    super.initState();
  }

  getBalanceTimer() {
    balanceTimer ??= Timer.periodic(const Duration(seconds: 10), (timer) {
      // timeCount -= 1;
      if (isLogin) {
        // if (timeCount <= 0) {
        //   timeCount = 5;
        webViewController.runJavaScript("getBalance()");
        // dioRate(message);
        // }
      } else {
        timer.cancel();
      }
    });
  }

  //btc function
  void initBTCWallet(String btcPath) {
    print("初始化btc Wallet" + btcPath);
    var seed = bip39.mnemonicToSeed(myWallet.mnemonic);
//    old
/*
    var wallet = HDWallet.fromSeed(seed);
    print("btc Address hd wallet : " + wallet.address);
    HDWallet btWallet = wallet.derivePath(btcPath);
    print("btc Address: " + btWallet.address);
*/

    final node = bip32.BIP32.fromSeed(seed);
    setState(() {
      if (btcPath.isEmpty) {
        print("mvc Path: " + myWallet.path);

        btcPath = "m/44'/${myWallet.path}'/0'/0/0";
      }
      // flutter build apk --no-sound-null-safety

      if (btcPath == "m/84'/0'/0'/0/0") {
        myWallet.btcAddress = get84Address(node.derivePath(btcPath));
      } else {
        myWallet.btcAddress = get44Address(node.derivePath(btcPath));
      }
      myWallet.btcPath = btcPath;
      print("btc Address: " + btcPath);
      if (myWallet.btcBalance.isEmpty) {
        myWallet.btcBalance = "0";
      }

      getNftData();
    });

    // sqWallet.updateDefaultData(myWallet);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("应用进入前台======");
        if (isFingerCan && isFore == false) {
          isFore = true;
          authenticateMe().then((value) {
            if (value) {
            } else {
              exit(0);
            }
          });
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        isFore = false;
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    // EventBusUtils.instance.destroy();
    _subscription_delete.cancel();
    _subscription_banlace.cancel();
    _subscription_banlace_btc.cancel();
    _subscription_btc_utxo.cancel();
  }

  late TabController tabController;

  List<Tab> _homeTopTabList = <Tab>[
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("images/btc_icon.png", width: 20, height: 20),
          const SizedBox(
            width: 5,
          ),
          Text(
            "BTC",
            style: getDefaultTextStyle(),
          )
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("images/icon.png", width: 24, height: 24),
          const SizedBox(
            width: 5,
          ),
          Text(
            "SPACE",
            style: getDefaultTextStyle(),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // authenticateMe().then((value) {
    //   bool auth=value;
    //
    // });

    print("渲染的tab 长度： "+_homeTopTabList.length.toString());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // brightness: Brightness.light,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    SqWallet sqWallet = SqWallet();
                    sqWallet.getAllWallet().then((value) {
                      if (value.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return MyWalletsDialog(
                                indo: this,
                                walletList: value,
                              );
                            });

                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return MyWalletListDialog(indo: this,isVisibility: true,walletList: value,);
                        //     });
                      } else {
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
                          Future.delayed(const Duration(milliseconds: 500), () {

                            if(walletMode==0){
                              if (index == 0) {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                      return const TransBtcRecordPage();
                                    }));
                              } else if (index == 1) {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                      return const TransRecordPage();
                                    }));
                              }
                            }else if(walletMode==1){
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return const TransBtcRecordPage();
                                  }));
                            }else if(walletMode==2){
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return const TransRecordPage();
                                  }));
                            }

                          });
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
                          return SettingsPage(
                            mainIndo: this,
                          );
                          // return const RequestPage();
                        }));
                      } else {
                        hasNoLogin(this);
                      }
                    },
                    child: Image.asset("images/mvc_more_icon.png",
                        width: 22, height: 22)),
              ),
              SimWebView(webViewController)
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Material(
              color: Colors.white,
              child: Row(
                children: [
                  TabBar(
                    labelColor: Colors.blue,
                    // unselectedLabelColor:  Color(SimColor.deaful_txt_color),
                    // unselectedLabelStyle: getDefaultGrayTextStyle(),
                    tabs: _homeTopTabList,
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                  ),
                  const Expanded(flex: 1, child: Text("")),
                  Row(
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //
                      //     if(isHomePage){
                      //       walletMode=0;
                      //       isHomePage=false;
                      //       Navigator.of(context).pushAndRemoveUntil(
                      //           MaterialPageRoute(
                      //               settings: const RouteSettings(name: "home"),
                      //               builder: (BuildContext context) {
                      //                 return HomePage(mContext: context);
                      //                 // return HomeTabPage();
                      //               }),
                      //               (route) => false);
                      //     }else{
                      //       isHomePage=true;
                      //       walletMode=2;
                      //       Navigator.of(context).pushAndRemoveUntil(
                      //           MaterialPageRoute(
                      //               settings: const RouteSettings(name: "home"),
                      //               builder: (BuildContext context) {
                      //                 return HomePage(mContext: context);
                      //                 // return HomeTabPage();
                      //               }),
                      //               (route) => false);
                      //     }
                      //
                      //   },
                      //   child: Text(
                      //     "MODE",
                      //     style: getDefaultTextStyle(),
                      //   ),
                      // ),

                      Container(
                        width: 110,
                        child: DropdownButton2<String>(
                            iconSize: 0,
                            isExpanded: true,
                            value: selectWalletName,
                            items: modeNameList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(e,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectWalletName = value!;
                                changeWalletMode(selectWalletName);

                              });
                            }),
                      ),

                      Image.asset("images/mvc_wallet_more_icon.png",
                          width: 10, height: 10),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
            controller: tabController,
            // children: _homeTopTabList.map((e) => MainBTCPage(indo: this)).toList()
            children: getWalletPageList()

            /*_homeTopTabList.map((Tab tab){
            if(_homeTopTabList.length>1){

            }else{
              if(walletMode==0){

              }
            }
            return MainBTCPage(indo: this);
          }).toList()*/
            ));
  }

  List<Widget> walletPageList = [];

  List<Widget> getWalletPageList() {
    walletPageList.clear();
    if (walletMode==1&&_homeTopTabList.length == 1) {
        walletPageList.add(MainBTCPage(indo: this));
    }else if(walletMode==2&&_homeTopTabList.length == 1){
      walletPageList.add(MainSpacePage(indo: this));
    } else {
      walletPageList.add(MainBTCPage(indo: this));
      walletPageList.add(MainSpacePage(indo: this));
    }

    print("返回的 walletPageList 长度是："+walletPageList.length.toString());

    return walletPageList;
  /*  if (_homeTopTabList.length == 1) {
      walletPageList.clear();
      if (walletMode == 1) {
        walletPageList.add(MainBTCPage(indo: this));
      } else if (walletMode == 2) {
        walletPageList.add(MainSpacePage(indo: this));
      }
      return walletPageList;
    } else {
      walletPageList.clear();
      walletPageList.add(MainBTCPage(indo: this));
      walletPageList.add(MainSpacePage(indo: this));

      return walletPageList;
    }*/

  }


  void changeWalletMode(String modeWalletName){
    if(modeWalletName=="BTC/SPACE"){
      walletMode=0;
    }else if(modeWalletName=="BTC"){
      walletMode=1;
    }else if(modeWalletName=="SPACE"){
      walletMode=2;
      ///
    }

    // SharedPreferencesUtils
    SharedPreferencesUtils.setInt("walletMode_key", walletMode);
    webViewController = WebViewController();

    showLoading(context);
    delayedDoSomeThing((){
      dismissLoading(context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) {
                return DefaultWidget();
              }),
              (route) => false);
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //         settings: const RouteSettings(name: "home"),
      //         builder: (BuildContext context) {
      //           return HomePage(mContext: context);
      //           // return HomeTabPage();
      //         }),
      //         (route) => false);
    },1);


  }


  @override
  void addWallet(
      String walletName, String mnemoni, String path, String btcPath) {
    // TODO: implement addWallet
    showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(isShow: true);
        });
    isShowLoadingDialog = true;
    isAddWallet = true;
    createWalletBtcPath = btcPath;

    var id = Random().nextInt(100000000).toString();
    webViewController.runJavaScript(
        "initMetaWallet('$mnemoni','$path','$id','$walletName')");
  }

  @override
  void createWallet(String name, String path, String btcPath) {
    webViewController.runJavaScript("generateMnemonic()");
    setState(() {
      walletName = name;
      createWalletPath = path;
      createWalletBtcPath = btcPath;
    });
  }

  @override
  void switchWallet(Wallet? wallet) {
    if (wallet != null) {
      showDialog(
          context: context,
          builder: (context) {
            return ProgressDialog(isShow: true);
          });
      isShowLoadingDialog = true;
      isAddWallet = true;
      isSwitchWallet = true;
      createWalletBtcPath = wallet.btcPath;

      webViewController.runJavaScript(
          "initMetaWallet('${wallet.mnemonic}','${wallet.path}','${wallet.id}','${wallet.name}')");
    }
  }
}

void dioRate(String message) async {
  final dio = getHttpDio();
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

  // 偶尔请求出错
  getBtcFee();
}

Future<void> getBTCBalance() async {
  // final dio=Dio();
  final dio = getHttpDio();
  Map<String, dynamic> map = {};

  map["address"] = myWallet.btcAddress;
  map["chain "] = "btc";
  Response response = await dio.get(BTC_BALANCE_V3_URL, queryParameters: map);
  if (response.statusCode == HttpStatus.ok) {
    Map<String, dynamic> dataResponse = response.data;
    BtcBalanceV3Response balanceResponse =
        BtcBalanceV3Response.fromJson(dataResponse);
    print("获取的btc余额是：${response.data.toString()}");
    num btc = balanceResponse.data!.balance!;
    // var btcNum = (btc / 100000000).toStringAsFixed(8);
    var btcNum = btc.toStringAsFixed(8);
    SqWallet sqWallet = SqWallet();
    myWallet.btcBalance = btcNum;
    sqWallet.update(myWallet);

    if (num.parse(btcNum) > 0) {
      Response response = await dio.get(MEYALET_RATE_URL);
      Map<String, dynamic> dataResponse = response.data;
      MetaLetRate metaLetRate = MetaLetRate.fromJson(dataResponse);
      num btcPrice = metaLetRate.data!.priceInfo!.btc!;
      print(metaLetRate.data!.priceInfo!.btc!.toString());

      EventBusUtils.instance.fire(WalletBTCData(btcNum.toString() + " BTC",
          "\$ ${(btcPrice * double.parse(btcNum)).toStringAsFixed(2)}"));
    } else {
      EventBusUtils.instance
          .fire(WalletBTCData(btcNum.toString() + " BTC", "\$ 0.0"));
    }
  }
}


