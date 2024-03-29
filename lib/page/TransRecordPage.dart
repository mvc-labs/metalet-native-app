import 'dart:convert';
import 'dart:io';
import 'dart:ui';

// import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/bean/TransRecordResponse.dart';
import 'package:mvcwallet/main.dart';
import '../constant/SimContants.dart';
import '../utils/Constants.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';
import 'RequestPage.dart';

class TransRecordPage extends StatefulWidget {
  const TransRecordPage({Key? key}) : super(key: key);

  @override
  State<TransRecordPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<TransRecordPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: TransRecordContent()

          // Column(
          //   children: const [
          //     TitleBack("Transaction Record"),
          //     TransRecordContent()
          //   ],
          // ),
          ),
    );
  }
}

class TransRecordContent extends StatefulWidget {
  const TransRecordContent({Key? key}) : super(key: key);

  @override
  State<TransRecordContent> createState() => _TransRecordContentState();
}

class _TransRecordContentState extends State<TransRecordContent> {
  final ScrollController _scrollController = ScrollController();
  List<TransRecordResponse> recordList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecordList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("触发加载更多");
        TransRecordResponse response = recordList[recordList.length - 1];

        if (response.flag!.isNotEmpty) {
          getRecordListLoadMore(response.flag);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getRecordList,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      // return const SettingsPage();
                      return HomePage();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("images/mvc_back_icon.png",
                          width: 22, height: 22),
                      const SizedBox(width: 5),
                      const Text(
                        "Back",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(SimColor.deaful_txt_color)),
                      ),
                    ],
                  )),
              // Expanded(
              //   child:
              // ),
              const Expanded(flex: 1, child: Text("")),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Image.asset("images/icon.png", width: 24, height: 24),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      "Transaction Record",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(SimColor.deaful_txt_color),
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(flex: 2, child: Text("")),
              // const Expanded(
              //   flex: 1,
              //   child:  ,),
              // Container(
              //   width: 50,
              //   child: Text(""),
              // )
            ],
          ),
          // const TitleBack("Transaction Record"),
          const SizedBox(height: 10),
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recordList.length,
                  itemBuilder: getListViewItemLayout,
                  controller: _scrollController,
                ),
              ))
        ],
      ),
    );
    //
    //   RefreshIndicator(
    //   onRefresh: getRecordList,
    //   child: ListView.builder(
    //     itemCount: recordList.length,
    //     itemBuilder: getListViewItemLayout,
    //   ),
    // );

    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 70,
    //         // decoration: BoxDecoration(color: Colors.red),
    //         width: double.infinity,
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Image.asset(
    //                   "images/icon.png",
    //                   width: 40,
    //                   height: 40,
    //                 ),
    //                 const SizedBox(width: 15),
    //                 Expanded(
    //                     flex: 1,
    //                     child: Column(
    //                       children: [
    //                         Row(
    //                           children: const [
    //                             Text(
    //                               "Balances",
    //                               style: TextStyle(
    //                                   color:
    //                                       Color(SimColor.deaful_txt_half_color),
    //                                   fontSize: 14),
    //                               textAlign: TextAlign.start,
    //                             )
    //                           ],
    //                         ),
    //                         const SizedBox(height: 5),
    //                         Row(
    //                           children: [
    //                             Text(spaceBalance,
    //                                 style: const TextStyle(
    //                                     color: Color(SimColor.deaful_txt_color),
    //                                     fontSize: 18))
    //                           ],
    //                         ),
    //                       ],
    //                     ))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       const Divider(),
    //       RefreshIndicator(
    //         onRefresh: getRecordList,
    //         child: ListView.builder(
    //           itemCount: recordList.length,
    //           itemBuilder: getListViewItemLayout,
    //         ),
    //       ),
    //     ],
    //   ),
    // ); ,

    // )
    // Column(
    //   children: const [
    //     TitleBack("Transaction Record"),
    //     TransRecordContent()
    //   ],
    // ),

    //
    //   RefreshIndicator(
    //   onRefresh: getRecordList,
    //   child: ListView.builder(
    //     itemCount: recordList.length,
    //     itemBuilder: getListViewItemLayout,
    //   ),
    // );

    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 70,
    //         // decoration: BoxDecoration(color: Colors.red),
    //         width: double.infinity,
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Image.asset(
    //                   "images/icon.png",
    //                   width: 40,
    //                   height: 40,
    //                 ),
    //                 const SizedBox(width: 15),
    //                 Expanded(
    //                     flex: 1,
    //                     child: Column(
    //                       children: [
    //                         Row(
    //                           children: const [
    //                             Text(
    //                               "Balances",
    //                               style: TextStyle(
    //                                   color:
    //                                       Color(SimColor.deaful_txt_half_color),
    //                                   fontSize: 14),
    //                               textAlign: TextAlign.start,
    //                             )
    //                           ],
    //                         ),
    //                         const SizedBox(height: 5),
    //                         Row(
    //                           children: [
    //                             Text(spaceBalance,
    //                                 style: const TextStyle(
    //                                     color: Color(SimColor.deaful_txt_color),
    //                                     fontSize: 18))
    //                           ],
    //                         ),
    //                       ],
    //                     ))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       const Divider(),
    //       RefreshIndicator(
    //         onRefresh: getRecordList,
    //         child: ListView.builder(
    //           itemCount: recordList.length,
    //           itemBuilder: getListViewItemLayout,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget getListViewItemLayout(BuildContext context, int index) {
    TransRecordResponse record = recordList[index];
    // DateTime dateTime =
    //     DateUtil.getDateTimeByMs(int.parse(record.time.toString()));
    // String showTime = DateUtil.formatDate(dateTime, format: "yyyy-MM-dd HH:mm");

    String showTime =
        TimeUtils.formatDateTime(int.parse(record.time.toString()));
    num recordMoney = 0;
    String showMoney = "";
    recordMoney = record.income! - record.outcome!;
    bool isInCome = true;
    var value = double.parse(recordMoney.toString()) / 100000000;
    if (recordMoney > 0) {
      // var valueRe = Decimal.parse(value.toString()).toStringAsFixed(8);
      showMoney = "+${value.toStringAsFixed(8)} Space";
      // showMoney="+$valueRe Space";
      isInCome = true;
    } else {
      // var valueRe = Decimal.parse(value.toString()).toStringAsFixed(8);
      showMoney = "${value.toStringAsFixed(8)} Space";
      isInCome = false;
      // showMoney="-$valueRe Space";
    }

    return Column(
      children: [
        InkWell(
          onTap: () {
            ClipboardData data = ClipboardData(text: record.txid!);
            Clipboard.setData(data);
            showToast("Copy transaction ID");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showTime,
                style: getDefaultTextStyle(),
              ),
              SizedBox(
                child: TextButton(
                  onPressed: () {
                    ClipboardData data = ClipboardData(text: record.txid!);
                    Clipboard.setData(data);
                    showToast("Copy transaction ID");
                  },
                  child: Row(children: [
                    Text(
                      showMoney,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(isInCome
                              ? SimColor.color_button_blue
                              : SimColor.deaful_txt_color),
                          decoration: TextDecoration.none),
                    ),
                    const SizedBox(width: 5),
                    Image.asset("images/icon_link.png", width: 20, height: 20),
                  ]),
                ),
              )
            ],
          ),
        ),
        const Divider(height: 20),
      ],
    );
  }

  getRecordListLoadMore(String? flag) async {
    print("www$flag");
    final dio = Dio();
    final response =
        await dio.get("$mvc_api/address/${myWallet.address}/tx?flag=$flag");
    if (response.statusCode == HttpStatus.ok) {
      // String stationsJson = jsonDecode(response.data);
      List<TransRecordResponse> items = [];
      final List<dynamic> stationsJson = response.data;
      items = List<TransRecordResponse>.from(
          stationsJson.map((e) => TransRecordResponse.fromJson(e)));
      setState(() {
        // recordList=items;
        recordList.clear();
        recordList.addAll(items);
      });
      print("recordList" + recordList.toString());
    }
  }

  Future<void> getRecordList() async {
    print("获取交易记录");
    String mvc_api="https://mainnet.mvcapi.com";
    print("请求连接 111 "+"$mvc_api/address/${myWallet.address}/tx");
    final dio = Dio();
    final response =
        await dio.get("$mvc_api/address/${myWallet.address}/tx");
    print("获取交易记录 111 "+response.data.toString());

    if (response.statusCode == HttpStatus.ok) {
      // String stationsJson = jsonDecode(response.data);
      List<TransRecordResponse> items = [];
      final List<dynamic> stationsJson = response.data;
      items = List<TransRecordResponse>.from(
          stationsJson.map((e) => TransRecordResponse.fromJson(e)));
      setState(() {
        // recordList=items;
        recordList.clear();
        recordList.addAll(items);
      });
      print("recordList" + recordList.toString());
    }
  }
}
