import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/ShowNftDetailPage.dart';

import '../bean/NftDetailBean.dart';
import '../constant/SimContants.dart';
import '../utils/MetaFunUtils.dart';
import 'RequestPage.dart';

class NftDetailListPage extends StatefulWidget {
  //其他参数
  String codehash;
  String genesis;
  String title;

  NftDetailListPage(
      {Key? key,
      required this.codehash,
      required this.genesis,
      required this.title})
      : super(key: key);

  @override
  State<NftDetailListPage> createState() => _NftDetailListPageState();
}

class _NftDetailListPageState extends State<NftDetailListPage> {
  final ScrollController _scrollController = ScrollController();
  List<Items> nftDetailsList = [];

  int page = 1;
  int pageSize = 30;
  bool isRefresh = true;
  String chain = "mvc";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNftDetailListData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        getNftDetailListDataMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: getNftDetailListData,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Column(
              children: [
                TitleBack2(widget.title, onPressed: () {
                  Navigator.of(context).pop();
                }),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        childAspectRatio: 75 / 100,
                      ),
                      itemCount: nftDetailsList.length,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: getGridViewItemLayout),
                )
              ],
            ),
          )),
    );
  }

  Widget getGridViewItemLayout(BuildContext context, int index) {
    Items data = nftDetailsList[index];
    MetaFunUtils metaFunUtils = MetaFunUtils();
    String url = metaFunUtils.getShowImageUrl(data.nftIcon!);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
          return ShowNftDetailPage(nftData: data);
        }));
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 110,
            decoration: ShapeDecoration(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.contain)),
          ),
          /* Expanded(
          flex: 1,
          // child: metaFunUtils.getImageContainerSizeCul(Image.network(url,fit: BoxFit.contain),100,100),
          child:Container(

            width: 130,
            height: 130,
            decoration: ShapeDecoration(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(3)
              ),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover
              )
            ),

          ),


        ),*/
          const SizedBox(
            height: 1,
          ),
          Text("#${data.nftTokenIndex}"),
          const SizedBox(
            height: 1,
          ),
          // Text("data"),
          Text(
            data.nftName!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Future<void> getNftDetailListData() async {
    page = 1;
    Map<String, dynamic> map = {};
    map["page"] = page;
    map["pageSize"] = pageSize;
    map["chain"] = chain;
    map["codehash"] = widget.codehash;
    map["genesis"] = widget.genesis;

    String url =
        "$mvc_metalet/v2/app/show/nft/${myWallet.address}/details";
    Dio dio = Dio();
    Response response = await dio.get(url, queryParameters: map);
    print("请求nftList数据：$response");
    Map<String, dynamic> data = response.data;

    NftDetailBean nftDetailBean = NftDetailBean.fromJson(data);
    List<Items> dataList = nftDetailBean.data!.results!.items!;
    setState(() {
      nftDetailsList.clear();
      nftDetailsList.addAll(dataList);
    });
  }

  Future<void> getNftDetailListDataMore() async {
    Map<String, dynamic> map = {};
    map["page"] = page;
    map["pageSize"] = pageSize;
    map["chain"] = chain;
    map["codehash"] = widget.codehash;
    map["genesis"] = widget.genesis;

    String url =
        "$mvc_metalet/v2/app/show/nft/${myWallet.address}/details";
    Dio dio = Dio();
    Response response = await dio.get(url, queryParameters: map);
    Map<String, dynamic> data = response.data;
    NftDetailBean nftDetailBean = NftDetailBean.fromJson(data);
    List<Items> dataList = nftDetailBean.data!.results!.items!;
    setState(() {
      if (dataList.isNotEmpty) {
        nftDetailsList.addAll(dataList);
      }
    });
  }
}
