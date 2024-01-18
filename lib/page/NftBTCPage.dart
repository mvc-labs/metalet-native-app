import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/btc/BtcNftBean.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/NftDetailListPage.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/btc/NftBTCDetailPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';

import '../bean/NftData.dart';
import '../constant/SimContants.dart';
import '../utils/EventBusUtils.dart';
import '../utils/SimStytle.dart';
import 'SimpleDialog.dart';

//NFT
class NftBTCPage extends StatefulWidget {
  const NftBTCPage({Key? key}) : super(key: key);

  @override
  State<NftBTCPage> createState() => _NftBTCPageState();
}

class _NftBTCPageState extends State<NftBTCPage> {
  //刷新
  // final ScrollController _scrollController = ScrollController();

  //填充数据
  List<BtcNftBeanList> nftList = [];

  bool isRefresh = true;
  bool showFt = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (btcNftResult!.isNotEmpty) {
      setState(() {
        nftList.clear();
        nftList.addAll(btcNftResult);
      });
    } else {
      getNftData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // EventBusUtils.instance.destroy();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: RefreshIndicator(
          onRefresh: getNftData2,
          child: Column(
            children: [
              Visibility(
                  visible: showFt,
                  child: Expanded(
                      flex: 1,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            //设置列数
                            crossAxisCount: 3,
                            //设置横向间距
                            // crossAxisSpacing: 3,
                            // childAspectRatio: 70/100,
                            // childAspectRatio:itemWidth / itemHeight,
                            childAspectRatio: 65 / 100,
                          ),
                          itemCount: nftList.length,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: getGridViewItemLayout))),
              Visibility(
                  visible: showFt == true ? false : true,
                  child: Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "images/default_img_nodata.png",
                              width: 100,
                              height: 100,
                            ),
                            const Text(
                              "NO DATA",
                              style: TextStyle(
                                  color: Color(SimColor.deaful_gray_txt_color),
                                  fontSize: 18),
                            )
                          ],
                        ),
                      )))
            ],
          )),
    );
    // return RefreshIndicator(
    //     onRefresh: getNftData,
    //     child: Column(
    //       children: [
    //         ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: nftList.length,
    //             itemBuilder: getListViewItemLayout)
    //       ],
    //     ));
  }

  Widget getGridViewItemLayout(BuildContext context, int index) {
    BtcNftBeanList nftDetailItemList = nftList.length - 1 > index
        ? nftList[index]
        : nftList[nftList.length - 1];
    String showTime = TimeUtils.formatDateTime(
        int.parse(nftDetailItemList.timestamp.toString()));

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 3 - 20;

    return InkWell(
      onTap: (){
        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
          return NftBTCDetailPage(nftDetailItemList: nftDetailItemList,);
        }));
      },
      child: Column(
        children: [
          Container(
            height: itemWidth,
            margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
            decoration: BoxDecoration(
              color: Color(SimColor.color_button_blue),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  color: Color(SimColor.color_button_blue), width: 0.7),
              // color: Color(0x1E2BFF), width: 0.7),
            ),
            // child: Align(
            //   child: Text(nftDetailItemList.nftShowContent!,style: TextStyle(
            //     fontSize: 13,
            //
            //   ),) ,
            // ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: itemWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(""),
                  ),
                  Container(
                    child: Text(
                      nftDetailItemList.nftShowContent!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  // Text(
                  //   nftDetailItemList.nftShowContent!,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //   ),
                  // ),
                  // ConstrainedBox(constraints: BoxConstraints(maxHeight: itemWidth),
                  //     child: Text(
                  //       nftDetailItemList.nftShowContent!,
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 10,
                  //       style: TextStyle(
                  //         fontSize: 13,
                  //       ),
                  //   ),
                  // ),
                  Expanded(
                    child: Text(""),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            // color: Color(SimColor.color_button_half_blue)),
                            color: Color(0xff767EFF)),
                        child: Text(
                          "546 sat",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "#${nftDetailItemList.inscriptionNumber}",
            style: getDefaultGraySmallTextStyle(),
          ),
          Text(
            showTime,
            style: getDefaultGraySmallTextStyle(),
          ),
        ],
      ),
    );
  }

  //get Data
  Future<void> getNftData() async {
    Map<String, dynamic> map = {};
    map["address"] = myWallet.btcAddress;
    map["size"] = 12;
    map["cursor"] = 0;
    Dio dio = getHttpDio();
    Response response = await dio.get(BTC_BRC20_NFT_URL, queryParameters: map);

    Map<String, dynamic> data = response.data;
    BtcNftBean nftData = BtcNftBean.fromJson(data);
    List<BtcNftBeanList> myNftList = nftData.data!.btcNftBeanList!;

    print("大小：" + myNftList.length.toString());

    if (!mounted) {
      return;
    }
    List<BtcNftBeanList> btcNftResult = [];

    for (int i = 0; i < myNftList.length; i++) {
      BtcNftBeanList bean = myNftList[i];
      Dio dio = getHttpDio();
      Response response = await dio.get(bean.content!, queryParameters: map);
      bean.nftShowContent = response.data.toString();
      btcNftResult.add(bean);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      nftList.clear();
      nftList.addAll(btcNftResult);
      if (myNftList.isEmpty) {
        showFt = false;
      }
    });
  }

  //get Data
  Future<void> getNftData2() async {}

// get Data
// Future<void> getNftDataMore() async {
//   String address = myWallet.address;
//   String chain = "mvc";
//   Map<String, dynamic> map = {};
//   map["page"] = page;
//   map["pageSize"] = pageSize;
//   map["chain"] = chain;
//   String url =
//       "$mvc_metalet/v2/app/show/nft/$address/summary";
//   Dio dio = Dio();
//   Response response = await dio.get(url, queryParameters: map);
//   Map<String, dynamic> data = response.data;
//   NftData nftData = NftData.fromJson(data);
//   List<Items> myNftList = nftData.data!.results!.items!;
//
//
//   setState(() {
//     if(myNftList.isNotEmpty){
//       nftList.addAll(myNftList);
//     }
//   });
// }
}
