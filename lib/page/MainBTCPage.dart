import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/BtcBalanceResponse.dart';
import 'package:mvcwallet/bean/MetaLetRate.dart';
import 'package:mvcwallet/constant/SimContants.dart';
import '../data/Indo.dart';
import '../main.dart';
import '../utils/Constants.dart';
import '../utils/EventBusUtils.dart';
import '../utils/SimColor.dart';
import 'RequestBtcPage.dart';
import 'btc/SendBtcPage.dart';

class MainBTCPage extends StatefulWidget {
  Indo indo;

  MainBTCPage({Key? key, required this.indo}) : super(key: key);

  @override
  State<MainBTCPage> createState() => _MainBTCPageState();
}

class _MainBTCPageState extends State<MainBTCPage> {
  late StreamSubscription _subscription_banlace_btc;

  @override
  void initState() {
    // TODO: implement initState
    // setState(() {
    //   btcBalance=myWallet.btcBalance+" BTC";
    // });

    _subscription_banlace_btc =
        EventBusUtils.instance.on<WalletBTCData>().listen((event) {
      // print(event.);
      setState(() {
        print("轮询获取的btc 信息11111111111111111 btcBalance ： " +
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

    // getBTCBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: const BoxDecoration(
// color: Colors.red,
                image: DecorationImage(
              image: AssetImage("images/bg_img_btc.png"),
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
                  btcWalletBalance,
                  style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color), fontSize: 40),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/btc_icon.png",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      // "21347.32 Spacessss",
                      btcBalance,
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
                                return const RequestBtcPage();
                              }));
                            } else {
                              hasNoLogin(widget.indo);
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
                                return SendBtcPage(
                                  result: "",
                                  isScan: false,
                                );
                              }));
                            } else {
                              hasNoLogin(widget.indo);
                            }
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
          // SimWebView(webViewController)
        ],
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription_banlace_btc.cancel();
  }

/*

  Future<void> getBTCBalance() async{
    final dio=Dio();
    Map<String, dynamic> map = {};
    map["address"] = myWallet.btcAddress;
    map["chain "] = "btc";
    Response response=await dio.get(BTC_BALANCE_URL,queryParameters: map);
    if(response.statusCode==HttpStatus.ok){
      Map<String, dynamic> dataResponse=response.data;
      BtcBalanceResponse balanceResponse=BtcBalanceResponse.fromJson(dataResponse);
      print("获取的btc余额是：${balanceResponse.data!.satoshi}");
      num  btc=balanceResponse.data!.satoshi!;
      var btcNum = (btc / 100000000).toStringAsFixed(8);

      if(num.parse(btcNum)>0){
        Response response=await dio.get(MEYALET_RATE_URL);
        Map<String, dynamic> dataResponse=response.data;
        MetaLetRate metaLetRate=MetaLetRate.fromJson(dataResponse);
        num btcPrice=metaLetRate.data!.priceInfo!.btc!;
        print(metaLetRate.data!.priceInfo!.btc!.toString());
        setState(() {
          btcBalance=btcNum.toString()+" BTC";
          btcWalletBalance = "\$ ${(btcPrice * double.parse(btcNum)).toStringAsFixed(2)}";
        });
      }else{
        setState(() {
          btcBalance=" 0.00000000 BTC";
          btcWalletBalance = "\$ 0.0";
        });
      }

    }



  }
*/
}
