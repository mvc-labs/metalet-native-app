import 'package:flutter/material.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../../bean/btc/BtcNftBean.dart';
import '../../utils/SimColor.dart';
import '../RequestBtcPage.dart';

class NftBTCDetailPage extends StatefulWidget {
  BtcNftBeanList nftDetailItemList;

  NftBTCDetailPage({Key? key, required this.nftDetailItemList})
      : super(key: key);

  @override
  State<NftBTCDetailPage> createState() => _NftBTCDetailPageState();
}

class _NftBTCDetailPageState extends State<NftBTCDetailPage> {
  late BtcNftBeanList nftDetailItemList;

  late String showTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nftDetailItemList = widget.nftDetailItemList;
    showTime = TimeUtils.formatDateTimeDetail(
        int.parse(nftDetailItemList.timestamp.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TitleBack(""),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    decoration: BoxDecoration(
                      color: Color(SimColor.color_button_blue),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Color(SimColor.color_button_blue), width: 0.7),
                      // color: Color(0x1E2BFF), width: 0.7),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 180),
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
                              maxLines: 8,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  height: 2),
                            ),
                          ),
                          Expanded(
                            child: Text(""),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    // color: Color(SimColor.color_button_half_blue)),
                                    color: Color(0xff767EFF)),
                                child: Text(
                                  "546 sat",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "#${nftDetailItemList.inscriptionNumber}",
                  style: TextStyle(
                      fontSize: 20, color: Color(SimColor.deaful_txt_color)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  showTime,
                  style: getDefaultGrayTextStyle(),
                ),
              ),
              Divider(
                height: 30,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ID:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 230),
                    child: Text(
                      nftDetailItemList.inscriptionId!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getDefaultTextStyle(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 230),
                    child: Text(
                      nftDetailItemList.address!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getDefaultTextStyle(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Output value:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  Text(
                    nftDetailItemList.outputValue.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getDefaultTextStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: (){
                  copyText( nftDetailItemList.preview!);
                },
                child:  Row(
                children: [
                  Text(
                    "Preview:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  Expanded(child: Text("")),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      nftDetailItemList.preview!,
                      overflow: TextOverflow.ellipsis,
                      style: getDefaultBlueTextStyle(),
                    ),
                  ),
                  Image.asset("images/add_icon_copy.png",width: 20,height: 15,)
                  // Expanded(child: Text(
                  //   nftDetailItemList.preview!,
                  //   style: getDefaultTextStyle(),
                  // ))
                ],
              ),),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: (){
                  copyText( nftDetailItemList.content!);
                },
                child:  Row(
                  children: [
                    Text(
                      "Content:",
                      style: getDefaultGrayTextStyle16(),
                    ),
                    Expanded(child: Text("")),

                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        nftDetailItemList.content!,
                        overflow: TextOverflow.ellipsis,
                        style: getDefaultBlueTextStyle(),
                      ),
                    ),
                    Image.asset("images/add_icon_copy.png",width: 20,height: 15,),
                  ],
                ),
              ),

              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Content Length:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  Text(
                    nftDetailItemList.contentLength.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getDefaultTextStyle(),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Content Type:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  Text(
                    nftDetailItemList.contentType.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getDefaultTextStyle(),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Timestamp:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  Text(
                    showTime,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getDefaultTextStyle(),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    "Genesis:",
                    style: getDefaultGrayTextStyle16(),
                  ),
                  Expanded(child: Text("")),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      nftDetailItemList.genesisTransaction!,
                      overflow: TextOverflow.ellipsis,
                      style: getDefaultTextStyle(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50,)

            ],
          ),
        ),
      ),
    );
  }
}
