import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/bean/FtRecord.dart';
import 'package:mvcwallet/constant/SimContants.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/SendFtPage.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../bean/Brc20ListBean.dart';
import '../../bean/BtcFtDetailBean.dart';
import '../../bean/FtData.dart';
import '../../utils/Constants.dart';
import '../../utils/MetaFunUtils.dart';
import '../../utils/SimColor.dart';
import '../RequestBtcPage.dart';


class BtcFtDetailPage extends StatefulWidget {
  TickList ftItem;

  BtcFtDetailPage({Key? key, required this.ftItem}) : super(key: key);

  @override
  State<BtcFtDetailPage> createState() => _BtcFtDetailPageState();

}

class _BtcFtDetailPageState extends State<BtcFtDetailPage> {
  String flag = "";
  List<InscriptionsList> recordList = [];
  int  page=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFtRecordData();
  }

  @override
  Widget build(BuildContext context) {
    MetaFunUtils metaFunUtils = MetaFunUtils();
    String url ="";

    return Scaffold(
      body: Container(
          margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TitleBack(""),
              Container(
                height: 240,
                width: double.infinity,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("images/bg_img_space.png"),
                //     )
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text(
                    //   "Balance",
                    //   style: TextStyle(
                    //       color: Color(SimColor.deaful_txt_half_color),
                    //       fontSize: 16),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ), //SimColor.deaful_txt_color
                    // Text(
                    //   "walletBalance",
                    //   style: const TextStyle(
                    //       color: Color(SimColor.deaful_txt_color), fontSize: 40),
                    // ),

                    ClipOval(
                      child: metaFunUtils.getImageContainerSize(
                          Image.network(url, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object execption,
                              StackTrace? stackTrace) {
                            return widget.ftItem.token=="ORXC"?Image.asset("images/ordi_icon.png",width: 20,height: 20,):Image.asset("images/img_token_default.png",width: 20,height: 20,);
                            // return Image.asset('assets/img_token_default.png');
                          }), 80, 80),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ClipOval(
                        //   child: metaFunUtils.getImageContainerSize(Image.network(url,fit: BoxFit.cover),30,30),
                        // ),
                        // const SizedBox(width: 10),
                        Text(
                          // "21347.32 Spacessss",
                          "${widget.ftItem.balance!}  ${widget.ftItem.token}",
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),

                    // InkWell(
                    //   onTap: () {
                    //     ClipboardData data =
                    //         ClipboardData(text: widget.ftItem.genesis!);
                    //     Clipboard.setData(data);
                    //     showToast("Copy Success");
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // decoration: const BoxDecoration(
                    //         //   color: Color(0xff26D2D7DE),
                    //         //   borderRadius:
                    //         //       BorderRadius.all(Radius.circular(10)),
                    //         // ),
                    //         child: ConstrainedBox(
                    //           constraints: const BoxConstraints(maxWidth: 220),
                    //           child: Text(
                    //             widget.ftItem.genesis!,
                    //             style: const TextStyle(
                    //               color: Color(SimColor.deaful_txt_color),
                    //               fontSize: 14,
                    //             ),
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(width: 8),
                    //       Image.asset("images/add_icon_copy.png",
                    //           width: 20, height: 20),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
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
                                  return const RequestBtcPage();
                                }));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(SimColor.color_button_blue))),
                              child: const Text("Request",
                                  style: TextStyle(fontSize: 16))),
                        )),
                    const SizedBox(width: 20),
                  /*  Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).push(CupertinoPageRoute(
                                //     builder: (BuildContext builder) {
                                //   return SendFtpage(
                                //     ftItem: widget.ftItem,
                                //   );
                                // }));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(SimColor.color_button_blue))),
                              child: const Text("Send",
                                  style: TextStyle(fontSize: 16)),
                            )))*/
                  ],
                ),
              ),
              // Container(
              //    height: window.physicalSize.height-300,
              //    child: ListView.builder(
              //        physics: NeverScrollableScrollPhysics(),
              //        shrinkWrap: true,
              //        itemCount: recordList.length,
              //        itemBuilder: getListViewItemLayout),
              //  ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Transaction History",
                    style: getDefaultTextStyle(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recordList.length,
                  itemBuilder: getListViewItemLayout,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }

  Widget getListViewItemLayout(BuildContext context, int index) {
    InscriptionsList record = recordList[index];
    // DateTime dateTime =
    // DateUtil.getDateTimeByMs(int.parse(record.time.toString()));
    // String showTime =
    // DateUtil.formatDate(dateTime, format: "yyyy-MM-dd HH:mm:ss");
    String showTime =
        TimeUtils.formatDateTime(int.parse(record.time.toString()));

    num recordMoney = 0;
    String showMoney = "";
    // recordMoney = record.income! - record.outcome!;
    bool isInCome = true;
    // num jindu = pow(10, widget.ftItem.decimalNum!);

    // var value = double.parse(recordMoney.toString()) / jindu;
    if (record.toAddress!.contains(myWallet.btcAddress)) {
      showMoney =
          "+ ${record.amount} ${record.token}";
      // showMoney =value.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      // showMoney = "+${Decimal.parse(value.toString()).toStringAsFixed(8)} ${widget.ftItem.symbol!}";

      // showMoney="+$valueRe Space";
      isInCome = true;
    } else {
      // var valueRe = Decimal.parse(value.toString()).toStringAsFixed(8);
      // showMoney = "${value.toStringAsFixed(8)} Space";
      showMoney =
          "-${record!.amount} ${record.token}";
      isInCome = false;
      // showMoney="-$valueRe Space";
    }

    String txid = record.txId!;

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(0xff26D2D7DE),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "•",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const Text(
                "Confirmed",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Text(
                showTime,
                style: TextStyle(
                    color: Color(SimColor.deaful_txt_half_color), fontSize: 14),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                showMoney,
                style: TextStyle(
                    color: isInCome ? Colors.green : Colors.red, fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              ClipboardData data = ClipboardData(text: txid);
              Clipboard.setData(data);
              showToast("Copy Success");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    txid,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(SimColor.deaful_txt_half_color),
                        fontSize: 14),
                  ),
                ),
                Image.asset("images/add_icon_copy.png", width: 13, height: 13),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> getFtRecordData() async {
    // https://api.show3.io/aggregation/v2/app/show/ft/1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9/summaries?chain=mvc&page=1&pageSize=30
    Map<String, dynamic> map = {};
    map["chain"] = "btc";
    map["tick"] = widget.ftItem.token;
    map["address"] = myWallet.btcAddress;
    map["page"] = page;

    Dio dio = Dio();
    Response response = await dio.get(METALET_BTC_FT_DETAIL_URL, queryParameters: map);

    if (response.statusCode == HttpStatus.ok) {
      List<InscriptionsList> items = [];
      BtcFtDetailBean btcFtDetailBean=BtcFtDetailBean.fromJson( response.data);
      items = btcFtDetailBean.data!.inscriptionsList!;
      setState(() {
        recordList.clear();
        recordList.addAll(items);
      });
      print(recordList.toString());
    }
  }
}
