import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/NftDetailListPage.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:mvcwallet/utils/SimColor.dart';

import '../bean/NftData.dart';
import '../constant/SimContants.dart';
import '../utils/EventBusUtils.dart';
import 'SimpleDialog.dart';

//NFT
class NftPage extends StatefulWidget {
  const NftPage({Key? key}) : super(key: key);

  @override
  State<NftPage> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> {
  late StreamSubscription  _subscription;
  //刷新
  final ScrollController _scrollController = ScrollController();

  //填充数据
  List<Items> nftList = [];
  List<NftDetailItemList> nftItemList=[];

  int page = 1;
  int pageSize = 30;
  bool isRefresh=true;
  bool showFt=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNftData();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        page++;
        getNftDataMore();
      }


    });



    _subscription= EventBusUtils.instance.on<SendNftSuccess>().listen((event) {
      Future.delayed(const Duration(seconds: 1),(){
        // showDialog(context: context, builder: (BuildContext context){
        //   return ShowNftSuccessDialog(nftName: sendNftDialogData.nftName!,nftIconUrl: sendNftDialogData.nftIconUrl!,nftTokenIndex: sendNftDialogData.nftTokenIndex!,receiveAddress:sendNftDialogData.receiveAddress!, transactionID: nftSendBack.txid!,);
        // });
         getNftData();
         //push test
      });


    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // EventBusUtils.instance.destroy();
    _subscription.cancel();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:RefreshIndicator(
          onRefresh: getNftData,
          child:
          Column(
            children: [

              Visibility(
                  visible: showFt,
                  child:  Expanded(
                    flex: 1,
                    child:  ListView.builder(
                        shrinkWrap: true,
                        itemCount: nftList.length,
                        controller: _scrollController,
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
          )) ,

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

  Widget getListViewItemLayout(BuildContext context, int index) {
    Items items=nftList[index];
    nftItemList=items.nftDetailItemList!;

    return Visibility(
        visible: nftItemList.isEmpty?false:true,
        child: InkWell(
      onTap:(){
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (BuildContext context){
              return NftDetailListPage(codehash: items.nftCodehash!, genesis: items.nftGenesis!,title: items.nftName!,);
            })
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items.nftSeriesName!,style: const TextStyle(
                  color: Color(SimColor.deaful_txt_color),
                  fontSize: 16,
                ),),
                const Expanded(flex: 1, child: Text("")),
                Text(items.nftMyCount.toString(),style: const TextStyle(color: Color(SimColor.gray_txt_color),fontSize: 13),),
                Image.asset(
                  "images/meta_right_icon.png",
                  width: 15,
                  height: 15,
                )
              ],
            ),
            const SizedBox(height: 12,),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //设置列数
                  crossAxisCount: 3,
                  //设置横向间距
                  crossAxisSpacing: 3,
                  childAspectRatio: 75/100,
                ),
                itemCount: nftItemList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemBuilder: getGridViewItemLayout)

            // Expanded(
            //     flex: 1,
            //     child:   GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       //设置列数
            //       crossAxisCount: 3,
            //       //设置横向间距
            //       crossAxisSpacing: 3,
            //     ),
            //     itemCount: nftItemList.length,
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemBuilder: getGridViewItemLayout))
          ],
        ),
      ),
    ));
  }



  Widget getGridViewItemLayout(BuildContext context, int index) {
    NftDetailItemList nftDetailItemList=nftItemList.length-1>index?nftItemList[index]:nftItemList[nftItemList.length-1];
    MetaFunUtils metaFunUtils=MetaFunUtils();
    String url=metaFunUtils.getShowImageUrl(nftDetailItemList.nftIcon!);
    print("object Url$url");

    return Column(
      children: [
        Container(
          width: 100,
          height: 110,
          decoration: ShapeDecoration(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.contain
              )
          ),

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
        const SizedBox(height: 1,),
        Text("#${nftDetailItemList.nftTokenIndex}"),
        const SizedBox(height: 1,),
        // Text("data"),
        Text(nftDetailItemList.nftName!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }


  //get Data
  Future<void> getNftData() async {
    page=1;
    String address = myWallet.address;
    String chain = "mvc";
    Map<String, dynamic> map = {};
    map["page"] = page;
    map["pageSize"] = pageSize;
    map["chain"] = chain;
    String url = "$mvc_metalet/v2/app/show/nft/$address/summary";
    // String url = "https://metalet.space/mvc-api/aggregation/v2/app/show/nft/$address/summary";
    // String url = "https://metalet.space/metasv/aggregation/v2/app/show/nft/$address/summary";
    Dio dio = Dio();
    Response response = await dio.get(url, queryParameters: map);
    Map<String, dynamic> data = response.data;
    NftData nftData = NftData.fromJson(data);
    List<Items> myNftList = nftData.data!.results!.items!;


    if(!mounted){
      return;
    }
    setState(() {
      nftList.clear();
      nftList.addAll(myNftList);
      if (myNftList.isEmpty) {
        showFt = false;
      }
    });
  }



  //get Data
  Future<void> getNftDataMore() async {
    String address = myWallet.address;
    String chain = "mvc";
    Map<String, dynamic> map = {};
    map["page"] = page;
    map["pageSize"] = pageSize;
    map["chain"] = chain;
    String url =
        "$mvc_metalet/v2/app/show/nft/$address/summary";
    Dio dio = Dio();
    Response response = await dio.get(url, queryParameters: map);
    Map<String, dynamic> data = response.data;
    NftData nftData = NftData.fromJson(data);
    List<Items> myNftList = nftData.data!.results!.items!;


    setState(() {
      if(myNftList.isNotEmpty){
        nftList.addAll(myNftList);
      }
    });
  }

}



