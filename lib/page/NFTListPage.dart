
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/FtData.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/utils/EventBusUtils.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/SimStytle.dart';
import 'FtBtcPage.dart';
import 'FtPage.dart';
import 'NftBTCPage.dart';
import 'NftPage.dart';

class NFTListPage extends StatefulWidget {
  const NFTListPage({Key? key}) : super(key: key);

  @override
  State<NFTListPage> createState() => _NFTListPageState();
}

class _NFTListPageState extends State<NFTListPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int index;
  static  final List<Tab> _homeTopTabList = <Tab>[
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
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      index = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Material(
            color: Colors.white,
            child:
            // TabBar(
            //       labelColor: Colors.blue,
            //       unselectedLabelColor: Colors.black54,
            //       tabs: _homeTopTabList,
            //       controller: tabController,
            //       indicatorSize: TabBarIndicatorSize.label,
            //       isScrollable: false,
            //     ),
            Row(
              children: [
                TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  tabs: _homeTopTabList,
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                ),
                // const Expanded(flex: 1, child: Text(""))
              ],
            )
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[NftPage(), NftBTCPage()],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }
}





