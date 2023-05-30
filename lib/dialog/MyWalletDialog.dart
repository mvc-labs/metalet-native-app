import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/sqlite/SqWallet.dart';
import 'package:mvcwallet/utils/Constants.dart';

import '../data/Indo.dart';
import '../page/SimpleDialog.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';

class MyWalletDialog extends Dialog {
  bool isVisibility;
  Indo indo;

  late TextEditingController walletNameController;
  late TextEditingController walletMnemoniController;
  late TextEditingController walletPathController;

  MyWalletDialog({super.key, required this.indo, required this.isVisibility}) {
    walletNameController = TextEditingController();
    walletMnemoniController = TextEditingController();
    walletPathController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisibility,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                width: double.infinity,
                height: 400,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const DialogTitleLayout(title: "Add/RestoreWallet"),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/input.png"),
                                fit: BoxFit.fill)),
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: "Wallet 2", border: InputBorder.none),
                          controller: walletNameController,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                            hintText: "mnemonic phrase",
                            border: InputBorder.none,
                          ),
                          controller: walletMnemoniController,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      // DialogBottomLayout(indo: indo,isVisibility: isVisibility)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                                visible: isVisibility,
                                child: Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 44,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(
                                                  SimColor.deaful_txt_color)),
                                        ),
                                      ),
                                    ))),
                            Visibility(
                              visible: isVisibility,
                              child: const SizedBox(width: 20),
                            ),
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                    height: 44,
                                    child: TextButton(
                                      onPressed: () {
                                        if (walletMnemoniController
                                            .text.isEmpty) {
                                          showToast(
                                              "Please enter the mnemonic");
                                        } else {
                                          String walletName = "";
                                          String walletPath = "";
                                          if (walletNameController
                                              .text.isNotEmpty) {
                                            walletName =
                                                walletNameController.text;
                                          } else {
                                            walletName = "Wallet";
                                          }
                                          if (walletPathController
                                              .text.isNotEmpty) {
                                            walletPath =
                                                walletPathController.text;
                                          } else {
                                            walletPath = "10001";
                                          }
                                          indo.addWallet(
                                              walletName,
                                              walletMnemoniController.text,
                                              walletPath);
                                          // showDialog(context: context, builder: (context){
                                          //   return ProgressDialog(isShow: true);
                                          // });
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(
                                                SimColor.color_button_blue)),
                                      ),
                                    )))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}


class MyWalletsDialog extends StatefulWidget {
  Indo indo;
  List<Wallet> walletList;
  double height = 250;
  Wallet? chooseWallet;

  // {super.key,
  // required this.indo,
  // required this.isVisibility,
  // required this.walletList}
  MyWalletsDialog({Key? key, required this.indo, required this.walletList})
      : super(key: key);

  @override
  State<MyWalletsDialog> createState() => _MyWalletsDialogState();
}

class _MyWalletsDialogState extends State<MyWalletsDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.walletList.length) {
      case 1:
        widget.height = 220;
        break;
      case 2:
        widget.height = 250;
        break;
      case 3:
        widget.height = 300;
        break;
      case 4:
        widget.height = 350;
        break;
      case 5:
        widget.height = 400;
        break;
    }

    if (widget.walletList.length > 5) {
      widget.height = 450;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.height,
          ),
          child: Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const DialogTitleLayout(title: "Add/Switch Wallet"),
                    const SizedBox(height: 30),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.walletList.length,
                              itemBuilder: getMyWalletItemLayout),
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // addMvcWallet(widget.indo);
                        hasNoLogin(widget.indo);
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Wallet",
                            style: getDefaultTextStyleTitle(),
                          ),
                        ],
                      ),
                    ),
                    // DialogBottomLayout(indo: indo,isVisibility: isVisibility)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                              visible: true,
                              child: Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 44,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(
                                                SimColor.deaful_txt_color)),
                                      ),
                                    ),
                                  ))),
                          const Visibility(
                            visible: true,
                            child: SizedBox(width: 20),
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  height: 44,
                                  child: TextButton(
                                    onPressed: () {
                                      widget.indo
                                          .switchWallet(widget.chooseWallet);
                                      Navigator.pop(context);
                                      SqWallet sqWallet = SqWallet();
                                      widget.chooseWallet!.isChoose = 1;
                                      sqWallet.updateDefaultData(widget.chooseWallet!);
                                    },
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(
                                              SimColor.color_button_blue)),
                                    ),
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget getMyWalletItemLayout(BuildContext context, int index) {
    Wallet wallet = widget.walletList[index];
    bool isSelect = false;
    if (wallet.isChoose == 1) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    // widget.
    // return StatefulBuilder(builder:(BuildContext context,StateSetter stateSetter){
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.chooseWallet = wallet;
              for (var o in widget.walletList) {
                o.isChoose = 0;
              }
              wallet.isChoose = 1;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                wallet.name,
                style: getDefaultTextStyleTitle(),
              ),
              Visibility(
                  visible: isSelect,
                  child: Image.asset("images/mvc_unit_select.png",
                      width: 15, height: 15))
            ],
          ),
        ),
        const Divider(height: 20)
      ],
    );
    // });
    // return ;
  }
}
