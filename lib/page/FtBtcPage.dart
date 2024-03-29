import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/Brc20ListBean.dart';
import 'package:mvcwallet/bean/Brc20ListV2Bean.dart';
import 'package:mvcwallet/bean/FtData.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';
import 'package:mvcwallet/constant/SimContants.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/FtDetailPage.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/btc/brc20/BtcFtDetailPage.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/EventBusUtils.dart';
import 'NftPage.dart';
import 'SimpleDialog.dart';

//FT
class FtBtcPage extends StatefulWidget {
  const FtBtcPage({Key? key}) : super(key: key);

  @override
  State<FtBtcPage> createState() => _FtBtcPageState();
}

class _FtBtcPageState extends State<FtBtcPage> {
  //刷新
  final ScrollController _scrollController = ScrollController();
  List<Brc20List> ftList = [];
  int page = 1;
  int pageSize = 30;
  String chain = "btc";

  late StreamSubscription _subscription;

  bool showFt = true;

  @override
  Widget build(BuildContext context) {
    return
      RefreshIndicator(child:   Column(
        children: [
          Expanded(child:  Visibility(
              visible: showFt,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ftList.length,
                    itemBuilder: getListViewItemLayout),
              )),),
          Visibility(
              visible: showFt == true ? false : true,
              child: Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "images/default_img_nodata.png", width: 100,
                          height: 100,),
                        const Text("NO DATA", style: TextStyle(
                            color: Color(SimColor.deaful_gray_txt_color),
                            fontSize: 18),)
                      ],
                    ),
                  )))
        ],
      ), onRefresh: getFtData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFtData();

    _subscription = EventBusUtils.instance.on<SendFtSuccess>().listen((event) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ShowFtSuccessDialog(
                  nftName: sendFtDialogData.nftName!,
                  receiveAddress: sendFtDialogData.receiveAddress!,
                  ftAmount: sendFtDialogData.ftAmount!,
                  transactionID: nftSendBack.txid!,
                );
              });
          getFtData();
        });
      });
    });
  }

  Widget getListViewItemLayout(BuildContext context, int index) {
    Brc20List ftItem = ftList[index];
    MetaFunUtils metaFunUtils = MetaFunUtils();
    // String url = metaFunUtils.getShowImageUrl(ftItem.icon!);
    String url = "";
    String ftName = ftItem.ticker!;
    String ftSymbolName = "BRC20";//ftItem.tokenType!;
    String ftNum = Decimal.parse(ftItem.availableBalance!).toString();

    // bool isShow = url == "https://api.show3.space/metafile/" ? false : true;
    bool isShow = true;

    print("接收的地址是：" + url);
    // String url=ftItem.icon!.replaceAll(regex, "");

    String iconPic="";

    switch(ftName.toLowerCase()){
      case "bili":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/bili.jpg";
        break;
      case "btcs":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/btcs.jpg";
        break;
      case "cats":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/cats.jpg";
        break;
      case "fish":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/fish.jpg";
        break;
      case "grum":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/grum.png";
        break;
      case "ibtc":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/ibtc.jpg";
        break;
      case "lger":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/lger.jpg";
        break;
      case "ordi":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/ordi.svg";
        break;

      case "orxc":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/orxc.png";
        break;
      case "oxbt":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/oxbt.png";
        break;
      case "rats":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/rats.jpg";
        break;
      case "rdex":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/rdex.png";
        break;
      case "sats":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/sats.jpg";
        break;
      case "sayc":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/sayc.jpg";
        break;
      case "trac":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/trac.png";
        break;
      case "vmpx":
        iconPic="$iconPic_Base/v3/coin/brc20/icon/vmpx.jpg";
        break;

    }



    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (BuildContext context) {
          return BtcFtDetailPage(ftItem: ftItem);
        }));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color(0xff26D2D7DE),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: isShow,
              // child:  metaFunUtils.getImageContainer(image))
              child: ClipOval(
                child: metaFunUtils
                    .getImageContainer(Image.network(iconPic, fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object execption,
                        StackTrace? stackTrace) {
                      return Image.asset("images/img_token_default.png",width: 20,height: 20,);
                      // return Image.asset('assets/img_token_default.png');
                    })),
              ),
            ),
            Visibility(
              visible: isShow,
              child: const SizedBox(
                width: 20,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ftName,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(SimColor.deaful_txt_color),
                          fontWeight: FontWeight.bold),
                    )),
                /* Row(
                children: [
                  // Align(alignment: Alignment.centerLeft,child: Text(ftName,)),
                  Text(ftName,)
                ],

              ),*/
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:  Container(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      decoration: const BoxDecoration(
                          color: Color(SimColor.color_btc_yellow_80),
                          borderRadius:
                          BorderRadius.all(Radius.circular(2))),
                      child:
                      Text(
                        ftSymbolName,
                        style: const TextStyle(
                            color: Color(SimColor.color_btc_yellow_text),
                            fontWeight: FontWeight.normal,
                            fontSize: 10),
                      )

                  ),),

                /* Row(
                children: [
                  // Align(alignment: Alignment.centerLeft,child: Text(ftSymbolName,))
                  Text(ftSymbolName,)
                ],
              )*/
              ],
            ),

            Expanded(
              flex: 1,
              child:   SizedBox(
                  child:Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          ftItem.overallBalance!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 3,),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text("- - - - - - - - - - - ",style: TextStyle(
                            color:Color( SimColor.gray_txt_color)
                        ),),
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: Text("Transferable:",style: getDefaultGraySmallTextStyle(),),
                      ),
                      SizedBox(height: 3,),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(ftItem.transferableBalance!,style: getDefaultTextStyle(),),
                      ),
                      SizedBox(height: 3,),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text("Available:",style: getDefaultGraySmallTextStyle(),),
                      ),
                      SizedBox(height: 3,),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(ftItem.availableBalance!,style: getDefaultTextStyle(),),
                      ),

                      SizedBox(height: 3,),

                      Visibility(
                        visible: num.parse(ftItem!.availableBalanceUnSafe!)>0?true:false ,
                        child:   Align(
                        alignment: Alignment.topRight,
                        child: Text("Available(pending):",style: getDefaultGraySmallTextStyle(),),
                      ),),
                      SizedBox(height: 3,),
                      Visibility(
                        visible: num.parse(ftItem!.availableBalanceUnSafe!)>0?true:false ,
                        child:  Align(
                        alignment: Alignment.topRight,
                        child: Text(ftItem.availableBalanceUnSafe!,style: getDefaultTextStyle(),),
                      ),)

                    ],
                  )),
            ),
            // const Expanded(
            //     flex: 1,
            //     child: Text("")),

            // SizedBox(width: 100,),

          ],
        ),
      ),
    );
  }

  Future<void> getFtData() async {
    // https://api.show3.io/aggregation/v2/app/show/ft/1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9/summaries?chain=mvc&page=1&pageSize=30
    Map<String, dynamic> map = {};
    map["address"] = myWallet.btcAddress;
    map["cursor"] = 0;
    map["size"] = 100000;

    Dio dio = Dio();
    Response response = await dio.get(
        MEYALET_BTC_BRC20_LIST_V2_URL, queryParameters: map);

    Map<String, dynamic> data = response.data;
    Brc20ListV2Bean ftData = Brc20ListV2Bean.fromJson(data);
    List<Brc20List> ftListData = ftData.data!.brc20List!;
    print(ftListData.toString());
    if (!mounted) {
      return;
    }

    setState(() {
      ftList.clear();
      ftList.addAll(ftListData);
      if (ftListData.isEmpty) {
        showFt = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // EventBusUtils.instance.destroy();
    _subscription.cancel();
  }
}
