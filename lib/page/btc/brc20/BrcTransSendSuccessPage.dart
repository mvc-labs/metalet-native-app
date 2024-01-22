import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/page/RequestBtcPage.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../../../bean/btc/Brc20CommitRequest.dart';
import '../../../btc/CommonUtils.dart';
import '../../../constant/SimContants.dart';
import '../../../utils/SimColor.dart';
import 'BrcTransSendSuccessTwoPage.dart';

class BrcTransSendSuccessPage extends StatefulWidget {

  Brc20CommitRequest brc20commitRequest;

   BrcTransSendSuccessPage({Key? key,required this.brc20commitRequest}) : super(key: key);

  @override
  State<BrcTransSendSuccessPage> createState() =>
      _BrcTransSendSuccessPageState();
}

class _BrcTransSendSuccessPageState extends State<BrcTransSendSuccessPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getBrcAvaiableData();




  }

  Future<void> getBrcAvaiableData() async{
    //
    Map<String,dynamic> map={};
    map["orderId"]=widget.brc20commitRequest.orderID!;

    Dio dio = getHttpDio();

    Response response=await dio.get(BTC_BRC20_INFO_URL,queryParameters: map);

    if(response.statusCode==HttpStatus.ok){
      print("brc info ："+response.data.toString());

    }

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
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text("")),
            Image.asset(
              "images/mvc_select_checkbox.png",
              width: 90,
              height: 90,
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Payment Sent",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: Text(
              "Your Transaction Has Been",
                style: getDefaultGrayTextStyle16(),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Successfully Sent",
                style: getDefaultGrayTextStyle16(),
              ),
            ),
            Expanded(child: Text("")),
            Container(
              height: 44,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(SimColor.color_button_blue))
                  ),
                  onPressed: (){

                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext builder){
                      return BrcTransSendSuccessTwoPage(brc20commitRequest: widget.brc20commitRequest,);
                    }));

                  },child: const Text("OK", style: TextStyle(fontSize: 16))),
            ),
            SizedBox(height: 10,)

          ],
        ),
      ),
    );
  }
}
