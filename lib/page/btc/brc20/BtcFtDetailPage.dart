import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/bean/FtRecord.dart';
import 'package:mvcwallet/bean/btc/Brc20Able.dart';
import 'package:mvcwallet/constant/SimContants.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/SendFtPage.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../../bean/Brc20ListBean.dart';
import '../../../bean/BtcFtDetailBean.dart';
import '../../../bean/FtData.dart';
import '../../../btc/CommonUtils.dart';
import '../../../utils/Constants.dart';
import '../../../utils/MetaFunUtils.dart';
import '../../../utils/SimColor.dart';
import '../../RequestBtcPage.dart';
import 'TransferBrc20Page.dart';

class BtcFtDetailPage extends StatefulWidget {

  TickList ftItem;

  BtcFtDetailPage({Key? key, required this.ftItem}) : super(key: key);

  @override
  State<BtcFtDetailPage> createState() => _BtcFtDetailPageState();
}

class _BtcFtDetailPageState extends State<BtcFtDetailPage> {
  String flag = "";
  List<InscriptionsList> recordList = [];
  int page = 1;

  String iconPic = "";
  Brc20Able? brc20able;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFtRecordData();
    getBrcAvaiableData();
    switch (widget.ftItem.token!.toLowerCase()) {
      case "bili":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/bili.jpg";
        break;
      case "btcs":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/btcs.jpg";
        break;
      case "cats":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/cats.jpg";
        break;
      case "fish":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/fish.jpg";
        break;
      case "grum":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/grum.png";
        break;
      case "ibtc":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/ibtc.jpg";
        break;
      case "lger":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/lger.jpg";
        break;
      case "ordi":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/ordi.svg";
        break;

      case "orxc":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/orxc.png";
        break;
      case "oxbt":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/oxbt.png";
        break;
      case "rats":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/rats.jpg";
        break;
      case "rdex":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/rdex.png";
        break;
      case "sats":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/sats.jpg";
        break;
      case "sayc":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/sayc.jpg";
        break;
      case "trac":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/trac.png";
        break;
      case "vmpx":
        iconPic = "$iconPic_Base/v3/coin/brc20/icon/vmpx.jpg";
        break;
    }
    // getBrcAvaiableData();
  }

  @override
  Widget build(BuildContext context) {
    MetaFunUtils metaFunUtils = MetaFunUtils();
    String url = "";

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          // brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: TitleBack3("")
          ),
        ),
      // appBar: AppBar(title: TitleBack(""),),
      body:Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 15),
        child: NestedScrollView(
          headerSliverBuilder: (context,innerBoxIsScrolled){
            return <Widget>[
              SliverToBoxAdapter(
                child:  Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                                Image.network(iconPic, fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object execption, StackTrace? stackTrace) {
                                      return Image.asset(
                                        "images/img_token_default.png",
                                        width: 20,
                                        height: 20,
                                      );
                                      // widget.ftItem.token=="ORXC"?Image.asset("images/ordi_icon.png",width: 20,height: 20,):
                                      // return Image.asset('assets/img_token_default.png');
                                    }),
                                80,
                                80),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  decoration: const BoxDecoration(
                                      color: Color(SimColor.color_btc_yellow),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                                  child: const Text(
                                    "BTC",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10),
                                  )),
                              const SizedBox(width: 5),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                  decoration: const BoxDecoration(
                                      color: Color(SimColor.color_btc_yellow_80),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                                  child: const Text(
                                    "BRC-20",
                                    style: TextStyle(
                                        color: Color(SimColor.color_btc_yellow_text),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10),
                                  ))
                            ],
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
                                style: const TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
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
                                      if(brc20able!=null){
                                        Navigator.of(context).push(CupertinoPageRoute(
                                            builder: (BuildContext builder) {
                                              return TransferBrc20Page(brc20able: brc20able!,);
                                            }));
                                      }

                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            const Color(SimColor.color_button_blue))),
                                    child: const Text("Transfer",
                                        style: TextStyle(fontSize: 16)),
                                  ))),
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
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transferable",style: getDefaultTextStyle(),),
                        Text("${widget.ftItem.transferBalance!} ${widget.ftItem.token!}",style: getDefaultTextStyle1(),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Available",style: getDefaultTextStyle(),),
                        Text("${widget.ftItem.availableBalance!} ${widget.ftItem.token!}",style: getDefaultTextStyle1(),)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                  ],
                ),
              ),
            ];
          },
          body:  ListView.builder(
            shrinkWrap: true,
            itemCount: recordList.length,
            itemBuilder: getListViewItemLayout,
          ),
        ),
      )
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
      showMoney = "+ ${record.amount} ${record.token}";
      // showMoney =value.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      // showMoney = "+${Decimal.parse(value.toString()).toStringAsFixed(8)} ${widget.ftItem.symbol!}";

      // showMoney="+$valueRe Space";
      isInCome = true;
    } else {
      // var valueRe = Decimal.parse(value.toString()).toStringAsFixed(8);
      // showMoney = "${value.toStringAsFixed(8)} Space";
      showMoney = "-${record!.amount} ${record.token}";
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
    // map["page"] = page;

    print("请求记录接口： "+METALET_BTC_FT_DETAIL_URL);
    print("请求记录接口tick： "+widget.ftItem.token!);
    print("请求记录接口address： "+myWallet.btcAddress);

    Dio dio = getHttpDio();



    Response response = await dio.get(METALET_BTC_FT_DETAIL_URL, queryParameters: map);
    // Response response = await dio.get("$METALET_BTC_FT_DETAIL_URL?chain=btc&tick=${widget.ftItem.token}&address=${myWallet.btcAddress}");

    if (response.statusCode == HttpStatus.ok) {
      List<InscriptionsList> items = [];
      BtcFtDetailBean btcFtDetailBean = BtcFtDetailBean.fromJson(response.data);
      items = btcFtDetailBean.data!.inscriptionsList!;
      setState(() {
        recordList.clear();
        recordList.addAll(items);
      });
      print(recordList.toString());
    }

  }


  Future<void> getBrcAvaiableData() async{
    //
    Map<String,dynamic> map={};
    map["address"]=myWallet.btcAddress;
    map["ticker"]=widget.ftItem.token!;

    map["address"]="bc1p4tx96s09yzqtv4m4rl69jywmect2t6qh5nyak5gmd7tpn4vkur6q3fj5j6";
    map["ticker"]="oxbt";

    print("请求brc20 Able ："+BTC_BRC20_ABLE_URL);

    Dio dio = getHttpDio();


    // Response response=await dio.get(BTC_BRC20_ABLE_URL,queryParameters: map);
    Response response=await dio.get("$BTC_BRC20_ABLE_URL?address=${myWallet.btcAddress}&ticker=${widget.ftItem.token!}");
    // Response response=await dio.get("https://www.metalet.space/wallet-api/v2/brc20/token-summary?address=bc1p4tx96s09yzqtv4m4rl69jywmect2t6qh5nyak5gmd7tpn4vkur6q3fj5j6&ticker=oxbt");

    if(response.statusCode==HttpStatus.ok){
      print("获取的brc结果："+response.data.toString());
      brc20able=Brc20Able.fromJson(response.data);


    }





  }






}
