
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/Indo.dart';
import '../main.dart';
import '../utils/Constants.dart';
import '../utils/EventBusUtils.dart';
import '../utils/SimColor.dart';
import 'RequestPage.dart';
import 'ScanResultPage.dart';
import 'SimpleDialog.dart';


class MainSpacePage extends StatefulWidget {

  Indo indo;

   MainSpacePage({Key? key,required this.indo}) : super(key: key);

  @override
  State<MainSpacePage> createState() => _MainSpacePageState();
}

class _MainSpacePageState extends State<MainSpacePage> {

  late StreamSubscription _subscription_banlace;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
                                    return ScanResultPage(
                                      result: "",
                                      isScan: false,
                                    );
                                  }));
                            } else {
                              hasNoLogin(widget.indo);
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

        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription_banlace.cancel();
  }

}
