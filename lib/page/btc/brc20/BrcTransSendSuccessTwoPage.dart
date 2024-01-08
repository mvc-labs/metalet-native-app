import 'package:flutter/material.dart';
import 'package:mvcwallet/page/RequestBtcPage.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../../../bean/btc/Brc20CommitRequest.dart';
import '../../../utils/SimColor.dart';

class BrcTransSendSuccessTwoPage extends StatefulWidget {

  Brc20CommitRequest brc20commitRequest;

  BrcTransSendSuccessTwoPage({Key? key,required this.brc20commitRequest}) : super(key: key);

  @override
  State<BrcTransSendSuccessTwoPage> createState() => _BrcTransSendSuccessTwoPageState();
}

class _BrcTransSendSuccessTwoPageState extends State<BrcTransSendSuccessTwoPage> {
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
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text("")),
            // Image.asset(
            //   "images/mvc_select_checkbox.png",
            //   width: 90,
            //   height: 90,
            // ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Inscribe Succes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30,),


            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Color(SimColor.color_button_blue),width: 0.7),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(""),),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child:Text(widget.brc20commitRequest.brc20_json!,style: getDefaultTextStyle(),) ,
                ),
                Expanded(
                  child: Text(""),),
                Container(
                  width: 160,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                  decoration: BoxDecoration(
                    color: Color(SimColor.color_button_blue),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2),bottomRight: Radius.circular(2)),

                  ),
                  child:  Text(
                    "unconfirmed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ) ,
            ),


            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: Text(
              "The transfeerable and available",
                style: getDefaultGrayTextStyle16(),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "balance of BRC20 will be rereshed in",
                style: getDefaultGrayTextStyle16(),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "a few minutes.",
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

                    Navigator.popUntil(context, ModalRoute.withName("home"));

                  },child: const Text("OK", style: TextStyle(fontSize: 16))),
            ),
            SizedBox(height: 10,)

          ],
        ),
      ),
    );
  }
}
