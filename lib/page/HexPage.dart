import 'package:flutter/material.dart';

import 'RequestBtcPage.dart';

class HexPage extends StatefulWidget {
  const HexPage({Key? key}) : super(key: key);

  @override
  State<HexPage> createState() => _HexPageState();
}

class _HexPageState extends State<HexPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

          ],
        ),
      ),
    );
  }
}
