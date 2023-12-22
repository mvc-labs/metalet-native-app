import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/Indo.dart';
import '../../utils/SimColor.dart';
import '../../utils/SimStytle.dart';
import '../RequestPage.dart';
import '../SimpleDialog.dart';

class RestoreWalletPage extends StatefulWidget {
  Indo indo;

  RestoreWalletPage({Key? key, required this.indo}) : super(key: key);

  @override
  State<RestoreWalletPage> createState() => _RestoreWalletPageState();
}

class _RestoreWalletPageState extends State<RestoreWalletPage> {
  late TextEditingController walletNameController;
  late TextEditingController walletMnemoniController;
  late TextEditingController walletPathController;

  String selectBTCPath = "m/44'/0'/0'/0/0";
  final List<String> btcPaths = [
    "m/44'/0'/0'/0/0",
    "m/84'/0'/0'/0/0",
    // "m/49'/0'/0'/0/0",
    // "m/86'/0'/0'/0/0"
  ];
  bool isSameMvcPath = true;

  @override
  void initState() {
    walletNameController = TextEditingController();
    walletMnemoniController = TextEditingController();
    walletPathController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                width: double.infinity,
                // decoration: const BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      const TitleBack("Create/Restore Wallet"),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          " Wallet name:",
                          style: getDefaultTextStyle1(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/input.png"),
                                fit: BoxFit.fill)),
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: "enter wallet name",
                              border: InputBorder.none),
                          controller: walletNameController,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          " Mnemonic:",
                          style: getDefaultTextStyle1(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 130,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/input_large_bg.png"),
                                fit: BoxFit.fill)),
                        child: TextField(
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText:
                                "enter your mnemonic phrase to restore wallet \nleave it blank to create new wallet",
                            border: InputBorder.none,
                          ),
                          controller: walletMnemoniController,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          " MVC Path:",
                          style: getDefaultTextStyle1(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/input.png"),
                                fit: BoxFit.fill)),
                        child: TextField(
                          decoration: const InputDecoration(
                              // hintText: "m/44'/10001'/0'",
                              hintText: "10001",
                              border: InputBorder.none),
                          controller: walletPathController,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          " BTC Path:",
                          style: getDefaultTextStyle1(),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      Row(
                        children: [
                          Switch(
                            activeColor: Color(SimColor.color_button_blue),
                              value: isSameMvcPath,
                              onChanged: (value) {
                                setState(() {
                                  isSameMvcPath = value;
                                });
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Use the same path as MVC")
                        ],
                      ),
                      Visibility(
                        visible: !isSameMvcPath,
                        child: Row(
                          children: [
                            DropdownButton2<String>(
                                value: selectBTCPath,
                                items: btcPaths.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectBTCPath = value!;
                                  });
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {


                                if (walletMnemoniController.text.isEmpty) {
                                  // showToast(
                                  //     "Please enter the mnemonic");
                                  //SimCreate
                                  String walletName = "";
                                  String walletPath = "";
                                  if (walletNameController.text.isNotEmpty) {
                                    walletName = walletNameController.text;
                                  } else {
                                    walletName = "Wallet";
                                  }

                                  walletPath = "10001";
                                  // if (walletPathController
                                  //     .text.isNotEmpty) {
                                  //   walletPath =
                                  //       walletPathController.text;
                                  // } else {
                                  //   walletPath = "10001";
                                  // }
                                  if(isSameMvcPath){
                                    selectBTCPath="m/44'/10001'/0'/0/0";
                                  }

                                  widget.indo
                                      .createWallet(walletName, walletPath,selectBTCPath);
                                  Navigator.of(context).pop();
                                } else {
                                  String walletName = "";
                                  String walletPath = "";
                                  if (walletNameController.text.isNotEmpty) {
                                    walletName = walletNameController.text;
                                  } else {
                                    walletName = "Wallet";
                                  }
                                  if (walletPathController.text.isNotEmpty) {
                                    walletPath = walletPathController.text;
                                  } else {
                                    walletPath = "10001";
                                  }

                                  if(isSameMvcPath){
                                    selectBTCPath="m/44'/$walletPath'/0'/0/0";
                                  }

                                  widget.indo.addWallet(walletName,
                                      walletMnemoniController.text, walletPath,selectBTCPath);
                                  // showDialog(context: context, builder: (context){
                                  //   return ProgressDialog(isShow: true);
                                  // });
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(SimColor.color_button_blue))),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // DialogBottomLayout(indo: indo,isVisibility: isVisibility)
                    ],
                  ),
                )),
          )),
    );
  }
}
