
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/bean/FtData.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/FtListPage.dart';
import 'package:mvcwallet/utils/EventBusUtils.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:sqflite/sqflite.dart';
import 'FtPage.dart';
import 'NftPage.dart';

class TokePage extends StatefulWidget {
  const TokePage({Key? key}) : super(key: key);

  @override
  State<TokePage> createState() => _TokePageState();
}

class _TokePageState extends State<TokePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int index;
  static const List<Tab> _homeTopTabList = <Tab>[
    Tab(
      text: 'FT',
    ),
    Tab(
      text: 'NFT',
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const TitleBack("Tokens"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Material(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
              tabs: _homeTopTabList,
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[FtListPage(), NftPage()],
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





