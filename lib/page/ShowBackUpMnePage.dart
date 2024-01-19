import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/Indo.dart';
import '../main.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';
import '../widget/CommsWidget.dart';
import 'RequestBtcPage.dart';

class ShowBackUpMnePage extends StatefulWidget {

  String phraseString;

  ShowBackUpMnePage({
    Key? key,required this.phraseString
  }) : super(key: key);

  @override
  State<ShowBackUpMnePage> createState() => _ShowBackUpMnePageState();
}

class _ShowBackUpMnePageState extends State<ShowBackUpMnePage> {

  List<String> phraseList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phraseList=widget.phraseString.split(" ");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: TitleBack(""),
      // ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 100, 30, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/step_two_icon.png",
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
                  "images/step_two_lock_icon.png",
                  width: width / 7,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Back up your Secret Key",
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
                "For your asset safety, please write down the seed phrase on a piece of paper and store it properly.",
                style: getDefaultGrayTextStyle16(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      color: Color(SimColor.gray_txt_color_border),
                      width: 0.5)),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 200 / 100,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: phraseList.length,
                  shrinkWrap: true,
                  itemBuilder: getGridViewItemLayout),
            ),
            Expanded(flex: 1, child: Text("")),
            getThemeButton(context, "I've backed up", function: () {
              webViewController=WebViewController();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) {
                return DefaultWidget();
              }), (route) => false);
            }),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );

    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Colors.white,
    //     elevation: 0,
    //     title: TitleBack(""),
    //   ),
    //   body: Container(
    //     margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
    //     child: Column(
    //       children: [
    //         InkWell(
    //           onTap: () {
    //            // Navigator.of(context).pop();
    //            Navigator.of(context).pushAndRemoveUntil(
    //                      MaterialPageRoute(
    //                          builder: (BuildContext context) {
    //                            return DefaultWidget();
    //                          }),
    //                          (route) => false);
    //           },
    //           child: Text("OK  备份助记词",style: TextStyle(
    //             fontSize: 30
    //           ),),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget getGridViewItemLayout(BuildContext context, int index) {

    String itemPhrase=phraseList[index];

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border:
              Border.all(color: Color(SimColor.gray_txt_color), width: 0.5)),
      child: Align(
        alignment: Alignment.center,
        child: Text(itemPhrase,style: getDefaultTextStyle(),),
      ),
    );
  }
}
