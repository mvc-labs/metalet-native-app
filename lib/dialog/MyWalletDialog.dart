import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/Indo.dart';
import '../page/SimpleDialog.dart';
import '../utils/SimColor.dart';

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
      visible:isVisibility ,
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
                        hintText: "mnemonicp hrase",
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
                  //这里写2个 Button
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
                                          color:
                                              Color(SimColor.deaful_txt_color)),
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
                                    indo.addWallet(
                                        walletNameController.text,
                                        walletMnemoniController.text,
                                        walletPathController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color(SimColor.color_button_blue)),
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

class DialogBottomLayout extends StatefulWidget {
  bool isVisibility;
  Indo indo;

  DialogBottomLayout({Key? key, required this.indo, required this.isVisibility})
      : super(key: key);

  @override
  State<DialogBottomLayout> createState() => _DialogBottomLayoutState();
}

class _DialogBottomLayoutState extends State<DialogBottomLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
              visible: widget.isVisibility,
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
                            color: Color(SimColor.deaful_txt_color)),
                      ),
                    ),
                  ))),
          Visibility(
            visible: widget.isVisibility,
            child: const SizedBox(width: 20),
          ),
          Expanded(
              flex: 1,
              child: SizedBox(
                  height: 44,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(SimColor.color_button_blue)),
                    ),
                  )))
        ],
      ),
    );
  }
}
