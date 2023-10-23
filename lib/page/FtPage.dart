import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/FtData.dart';
import 'package:mvcwallet/constant/SimContants.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/FtDetailPage.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/EventBusUtils.dart';
import 'NftPage.dart';
import 'SimpleDialog.dart';

//FT
class FtPage extends StatefulWidget {
  const FtPage({Key? key}) : super(key: key);

  @override
  State<FtPage> createState() => _FtPageState();
}

class _FtPageState extends State<FtPage> {
  //刷新
  final ScrollController _scrollController = ScrollController();
  List<Items> ftList = [];

  int page = 1;
  int pageSize = 30;
  String chain = "mvc";

  late StreamSubscription _subscription;

  bool showFt = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: getFtData,
        child: Column(
          children: [
            Visibility(
                visible: showFt,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ftList.length,
                      itemBuilder: getListViewItemLayout),
                )),
            Visibility(
                visible: showFt == true ? false : true,
                child:  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
                          mainAxisSize:MainAxisSize.min ,
                          children: [
                            Image.asset("images/default_img_nodata.png",width: 100,height: 100,),
                            const Text("NO DATA",style: TextStyle(color: Color(SimColor.deaful_gray_txt_color),fontSize: 18),)
                          ],
                      ),
                    )))
          ],
        ));
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
    Items ftItem = ftList[index];
    MetaFunUtils metaFunUtils = MetaFunUtils();
    String url = metaFunUtils.getShowImageUrl(ftItem.icon!);

    String ftName = ftItem.name!;
    String ftSymbolName = ftItem.symbol!;
    String ftNum = Decimal.parse(ftItem.balance!).toString();

    bool isShow = url == "https://api.show3.space/metafile/" ? false : true;

    print("接收的地址是：" + url);
    // String url=ftItem.icon!.replaceAll(regex, "");

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (BuildContext context) {
          return FtDetailPage(ftItem: ftItem);
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
                    .getImageContainer(Image.network(url, fit: BoxFit.cover)),
              ),
            ),
            Visibility(
              visible: isShow,
              child: const SizedBox(
                width: 20,
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ftName,
                        style: const TextStyle(
                            fontSize: 14,
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
                      child: Text(
                        ftSymbolName,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ))
                  /* Row(
                children: [
                  // Align(alignment: Alignment.centerLeft,child: Text(ftSymbolName,))
                  Text(ftSymbolName,)
                ],
              )*/
                ],
              ),
            ),
            // const Expanded(
            //     flex: 1,
            //     child: Text("")),

            // SizedBox(width: 100,),
            SizedBox(
                width: 110,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ftNum,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> getFtData() async {
    // https://api.show3.io/aggregation/v2/app/show/ft/1C2XjqoXHRegJNnmJqGDMt3rbAcrYLX4L9/summaries?chain=mvc&page=1&pageSize=30
    Map<String, dynamic> map = {};
    map["page"] = page;
    map["pageSize"] = pageSize;
    map["chain"] = chain;
    String url = "$mvc_metalet/v2/app/show/ft/${myWallet.address}/summaries";

    Dio dio = Dio();
    Response response = await dio.get(url, queryParameters: map);

    Map<String, dynamic> data = response.data;
    FtData ftData = FtData.fromJson(data);
    List<Items> ftListData = ftData.data!.results!.items!;
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
