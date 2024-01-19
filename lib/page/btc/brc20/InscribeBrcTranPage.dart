import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/bean/btc/Brc20CommitRequestBean.dart';
import 'package:mvcwallet/bean/btc/Brc20CommitResponseBean.dart';
import 'package:mvcwallet/bean/btc/Brc20PreDataBean.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/btc/brc20/Brc20TranHexPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../../bean/btc/Brc20Able.dart';
import '../../../bean/btc/Brc20CommitRequest.dart';
import '../../../constant/SimContants.dart';
import '../../FtBtcPage.dart';
import '../../FtPage.dart';
import '../../RequestBtcPage.dart';
import '../BtcSignData.dart';
import 'Brc20JsonBean.dart';
import 'Brc20TranPrePage.dart';
import 'BrcTransSendSuccessPage.dart';

class InscribeBrcTranPrePage extends StatefulWidget {

  Brc20CommitRequest brc20commitRequest;
  BtcSignData btcSignData;

  InscribeBrcTranPrePage({Key? key,required this.brc20commitRequest,required this.btcSignData}) : super(key: key);

  @override
  State<InscribeBrcTranPrePage> createState() => _InscribeBrcTranPageState();
}

class _InscribeBrcTranPageState extends State<InscribeBrcTranPrePage>
    with SingleTickerProviderStateMixin {
  bool isData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          title: const TitleBack("Inscribe Transfer"),
        ),
        body: Container(
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Spend Amount",
                            style: getDefaultGrayTextStyle18(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${widget.brc20commitRequest.brc_amount} ${widget.brc20commitRequest.brc_ticker}",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(SimColor.deaful_txt_color)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${(widget.btcSignData.netWorkFee! / 100000000).toStringAsFixed(8)} (network fee)",
                            style: getDefaultGrayTextStyle18(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isData = true;
                                });
                              },
                              child: Text(
                                "Data",
                                style: isData
                                    ? getDefaultTextStyle18()
                                    : getDefaultGrayTextStyle18(),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isData = false;
                                });
                              },
                              child: Text(
                                "Hex",
                                style: isData
                                    ? getDefaultGrayTextStyle18()
                                    : getDefaultTextStyle18(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Visibility(
                                visible: true,
                                child: Container(
                                  width: 35,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: isData
                                          ? Color(SimColor.deaful_txt_color)
                                          : Colors.transparent),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Visibility(
                                visible: true,
                                child: Container(
                                  width: 30,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: isData
                                          ? Colors.transparent
                                          : Color(SimColor.deaful_txt_color)),
                                )),
                          ],
                        ),
                        Divider(
                          height: 0.5,
                          thickness: 0.7,
                        ),
                        Visibility(visible: isData, child: Brc20TranPrePage(btcSignData: widget.btcSignData,)),
                        Visibility(visible: !isData, child: Brc20TranHexPage(btcSignData: widget.btcSignData,)),
                        Visibility(
                            visible: !isData,
                            child: InkWell(
                              onTap: () {
                                ClipboardData data =   ClipboardData(text: widget.btcSignData.rawTx!);
                                Clipboard.setData(data);
                                showToast("Copy Success");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/add_icon_copy.png",
                                      width: 16, height: 16),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Copy psbt transaction data",
                                    style: getDefaultGrayTextStyle(),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   "sjfisjfijewifjsifjsdijfisdjfiojsifjsijfiesjf",
                        //   style: TextStyle(fontSize: 100),
                        // )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 30,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                width: 1,
                                color: const Color(SimColor.color_button_blue),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(
                                    SimColor.color_button_blue,
                                  ),
                                  fontSize: 15),
                            ),
                          ),
                        ),),
                        Expanded(child: Text("")),
                        InkWell(onTap: (){

                          if(isFingerCan){
                            authenticateMe().then((value) {
                              if(value){
                                //正确
                                sendCommitInscribe();
                              }
                            });
                          }else{
                            //  TODO 继续
                            sendCommitInscribe();
                          }

                        },
                        child:  Container(
                          width: 100,
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              color: Color(SimColor.color_button_blue)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 11, 20, 11),
                            child: Text("Confirm",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ),
                        ),)
                      ],
                    ))
              ],
            )));
  }



  void sendCommitInscribe() async {

    Brc20CommitRequestBean  brc20commitRequestBean=Brc20CommitRequestBean();
    brc20commitRequestBean.version=0;
    brc20commitRequestBean.orderId=widget.brc20commitRequest.orderID;
    brc20commitRequestBean.feeAddress=myWallet.btcAddress;
    brc20commitRequestBean.rawTx=widget.btcSignData.rawTx;
    brc20commitRequestBean.net="livenet";
    brc20commitRequestBean.addressType=1;

    print('commit: '+brc20commitRequestBean.toString());

    Dio dio = getHttpDio();
    var jsonString=jsonEncode(brc20commitRequestBean.toJson());
    print("jsonString1111 "+jsonString);
    Response response = await  dio.post(BTC_BRC20_COMMIT_URL,data: jsonString);
    var data = response.data.toString();
    print("inscir "+data);
    if(response.statusCode==HttpStatus.ok){
      Brc20CommitResponseBean brc20commitResponseBean=Brc20CommitResponseBean.fromJson(response.data);
      if(brc20commitResponseBean.code==0){
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext builder){
          return BrcTransSendSuccessPage(brc20commitRequest: widget.brc20commitRequest,);
        }));
      }else{

        showToast(response.data.toString());

      }
    }
  }


}
