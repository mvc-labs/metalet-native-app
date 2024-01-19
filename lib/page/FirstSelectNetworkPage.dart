import 'package:flutter/material.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../btc/CommonUtils.dart';
import '../data/Indo.dart';
import '../utils/Constants.dart';
import '../widget/CommsWidget.dart';
import 'RequestBtcPage.dart';

class FirstSelectNetworkPage extends StatefulWidget {
  Indo indo;
  int selectWalletMode=0;

  FirstSelectNetworkPage({Key? key, required this.indo}) : super(key: key);

  @override
  State<FirstSelectNetworkPage> createState() => _FirstSelectNetworkPageState();
}


class _FirstSelectNetworkPageState extends State<FirstSelectNetworkPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;



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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/step_one_icon.png",
                  width: width / 3,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/step_one_ball_icon.png",
                  width: width / 6,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Select NetWork",
                style: TextStyle(
                    fontSize: 22, color: Color(SimColor.deaful_txt_color)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Choose the Network you need to use",
                style: getDefaultGrayTextStyle16(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (){
                setState(() {
                  widget.selectWalletMode=1;
                });
              },
              child:  Row(
                children: [
                  Image.asset(
                    "images/btc_icon.png",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Bitcoin",
                    style: getDefaultTextStyle1(),
                  ),
                  const Expanded(flex: 1, child: Text("")),
                  Image.asset(
                    widget.selectWalletMode==1?"images/mvc_select_checkbox.png":"images/mvc_normal_checkbox.png",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
               setState(() {
                 widget.selectWalletMode=2;
               });
              },
              child:    Row(
                children: [
                  Image.asset(
                    "images/mvc_icon.png",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Microvisionchain",
                    style: getDefaultTextStyle1(),
                  ),
                  const Expanded(flex: 1, child: Text("")),
                  Image.asset(
                    widget. selectWalletMode==2?"images/mvc_select_checkbox.png":"images/mvc_normal_checkbox.png",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
              setState(() {
                widget.selectWalletMode=0;
              });
              },
              child:    Row(
                children: [
                  Image.asset(
                    "images/btc_icon.png",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Bitcoin",
                    style: getDefaultTextStyle1(),
                  ),
                  Text(
                    " & ",
                    style: getDefaultTextStyle(),
                  ),
                  Image.asset(
                    "images/mvc_icon.png",
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    " Microvisionchain",
                    style: getDefaultTextStyle(),
                  ),
                  const Expanded(flex: 1, child: Text("")),
                  Image.asset(
                    widget.selectWalletMode==0?"images/mvc_select_checkbox.png":"images/mvc_normal_checkbox.png",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Expanded(
                flex: 1,
                child: Text("")),
            getThemeButton(context,"Next",function: () {
              setState(() {
                String walletName = "Wallet01";
                String walletPath = "10001";
                String selectBTCPath = "m/44'/10001'/0'/0/0";
                walletMode=widget.selectWalletMode;
                SharedPreferencesUtils.setInt("walletMode_key", walletMode);
                Navigator.of(context).pop();
                widget.indo.createWallet(walletName, walletPath, selectBTCPath);
                // Navigator.of(context).pop();
                // delayedDoSomeThing((){
                //   Navigator.of(context).pushAndRemoveUntil(
                //       MaterialPageRoute(
                //           builder: (BuildContext context) {
                //             return DefaultWidget();
                //           }),
                //           (route) => false);
                // },10);
                });
            }),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
