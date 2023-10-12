import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/bean/NftDetailBean.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/TransNftPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/SimColor.dart';

import '../utils/MetaFunUtils.dart';
import 'RequestPage.dart';
import '../utils/SimStytle.dart';

class ShowNftDetailPage extends StatefulWidget {
  Items nftData;

  ShowNftDetailPage({Key? key, required this.nftData}) : super(key: key);

  @override
  State<ShowNftDetailPage> createState() => _ShowNftDetailPageState();
}

class _ShowNftDetailPageState extends State<ShowNftDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = new DateTime.now();

    var a = now.millisecondsSinceEpoch; // 时间戳

    print(DateTime.fromMillisecondsSinceEpoch(a).toString().substring(0, 19));
  }

  @override
  Widget build(BuildContext context) {
    MetaFunUtils metaFunUtils = MetaFunUtils();
    String url = metaFunUtils.getShowImageUrl(widget.nftData.nftIcon!);
    String issAvatarurl = metaFunUtils.getShowImageUrl(widget.nftData.nftIssueAvatarTxId!);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Stack(
          children: [
            Column(
              children: [
                const TitleBack(""),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  decoration: ShapeDecoration(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(url), fit: BoxFit.fitHeight)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "${widget.nftData.nftName!} - #${widget.nftData.nftTokenIndex!}",
                              style: const TextStyle(
                                  color: Color(SimColor.deaful_txt_color),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                              decoration: const BoxDecoration(
                                  color: Color(0xff767EFF),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                              child: const Text(
                                "MVC",
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                              decoration: const BoxDecoration(
                                  color: Color(0xff80999FFF),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                              child: const Text(
                                "MetaContract",
                                style: TextStyle(
                                    color: Color(0xff787FFF), fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Text(
                              "Creator : ",
                              style: getDefaultGrayTextStyle(),
                            ),
                            const Expanded(flex: 1, child: Text("")),
                            ClipOval(child:
                              metaFunUtils.getImageContainerSize(Image.network(issAvatarurl), 22, 22)
                              ,),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.nftData.nftIssuer!,
                              style: getDefaultTextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              "Token Index : ",
                              style: getDefaultGrayTextStyle(),
                            ),
                            const Expanded(flex: 1, child: Text("")),
                            Text(
                              widget.nftData.nftTokenIndex!,
                              style: getDefaultTextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            ClipboardData data =   ClipboardData(text:  widget.nftData.nftGenesis!);
                            Clipboard.setData(data);
                            showToast("Copy Success");
                          },
                          child: Row(
                            children: [
                              Text(
                                "Series Genesis : ",
                                style: getDefaultGrayTextStyle(),
                              ),
                              const Expanded(flex: 1, child: Text("")),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 120),
                                child: Text(
                                  widget.nftData.nftGenesis!,
                                  style: getDefaultTextStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Text(
                                "Copy Check",
                                style: TextStyle(color: Color(0xff5173B9)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              "Last Activity At: ",
                              style: getDefaultGrayTextStyle(),
                            ),
                            const Expanded(flex: 1, child: Text("")),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(int.parse(
                                  widget.nftData!.nftTimestamp!.toString()))
                                  .toString()
                                  .substring(0, 19),
                              style: getDefaultTextStyle(),
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
            Positioned(
                bottom: 50,
                right: 10,
                left: 10,
                child:
              SizedBox(
                height: 50,
                child:   ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push( CupertinoPageRoute(builder: (BuildContext context){
                      return TransNftpage(nftName: widget.nftData.nftName!, nftIconUrl: url, nftTokenIndex: widget.nftData.nftTokenIndex!,nftGenesis: widget.nftData.nftGenesis!,nftCodehash: widget.nftData.nftCodehash!,);
                    }));
                  },
                  style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(SimColor.color_button_blue))
                  ) ,
                  child: const Text("Transfers",style:TextStyle(color: Colors.white,fontSize: 15),),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
