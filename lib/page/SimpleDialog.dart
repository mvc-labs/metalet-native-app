import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/sqlite/SqWallet.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/Constants.dart';
import '../utils/EventBusUtils.dart';
import '../utils/SimColor.dart';

// ignore: must_be_immutable
// class MyWalletDialog extends Dialog {
//   void Function()? onConfirm;
//   bool isVisibility;
//
//
//   late TextEditingController walletNameController;
//   late TextEditingController walletMnemoniController;
//   late TextEditingController walletPathController;
//
//   MyWalletDialog({super.key, required this.onConfirm, required this.isVisibility}){
//     walletNameController=TextEditingController();
//     walletMnemoniController=TextEditingController();
//     walletPathController=TextEditingController();
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       type: MaterialType.transparency,
//       child: Center(
//         child: Container(
//             margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
//             width: double.infinity,
//             height: 400,
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   const DialogTitleLayout(title: "Add/RestoreWallet"),
//                   const SizedBox(height: 30),
//                   Container(
//                     height: 50,
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("images/input.png"),
//                             fit: BoxFit.fill)),
//                     child:  TextField(
//                       decoration: const InputDecoration(
//                           hintText: "Wallet 2", border: InputBorder.none),
//                       controller: walletNameController,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     height: 130,
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("images/input_large_bg.png"),
//                             fit: BoxFit.fill)),
//                     child:  TextField(
//                       maxLines: 10,
//                       decoration: const InputDecoration(
//                         hintText: "mnemonicp hrase",
//                         border: InputBorder.none,
//                       ),
//                       controller: walletMnemoniController,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     height: 50,
//                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("images/input.png"),
//                             fit: BoxFit.fill)),
//                     child:  TextField(
//                       decoration: const InputDecoration(
//                           // hintText: "m/44'/10001'/0'",
//                           hintText: "10001",
//                           border: InputBorder.none),
//                       controller: walletPathController,
//                     ),
//                   ),
//                   //这里写2个 Button
//                   DialogBottomLayout(
//                       onConfirm: onConfirm, isVisibility: isVisibility)
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }

//Delete Wallet
class DeleteWalletDialog extends StatefulWidget {
  const DeleteWalletDialog({Key? key}) : super(key: key);

  @override
  State<DeleteWalletDialog> createState() => _DeleteWalletDialogState();
}

class _DeleteWalletDialogState extends State<DeleteWalletDialog> {
  late Timer _timer;
  var _countdownTime = 5;
  bool isOK = false;

  _DeleteWalletDialogState() {
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Delete Wallet"),
                        const Divider(height: 35),
                        const SizedBox(height: 15),
                        Text(
                          "Are you sure you want to delete this ${myWallet.name}? Please ensure that you have backed up the mnemonic phrase for this wallet before deleting.",
                          style: getDefaultTextStyle(),
                        ),
                        const SizedBox(height: 30),
                        Row(
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
                                        if (isOK) {
                                          Navigator.of(context)
                                            ..pop()
                                            ..pop();
                                          showToast("Delete Success");
                                          setState(() {
                                            isLogin = false;
                                            SqWallet sqWallet=SqWallet();
                                            sqWallet.delete(myWallet);
                                            // deleteWallet();
                                            balanceTimer!.cancel();
                                            Future.delayed(const Duration(seconds: 1),(){
                                              EventBusUtils.instance
                                                  .fire(DeleteWallet());
                                            });
                                          });
                                        }
                                      },
                                      child: handleText(),
                                    )))
                          ],
                        )
                      ],
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  startCountdown() {
    //倒计时时间
    call(timer) {
      if (_countdownTime < 1) {
        _timer.cancel();
      } else {
        setState(() {
          _countdownTime -= 1;
          if (_countdownTime <= 0) {
            isOK = true;
          }
        });
      }
    }

    _timer = Timer.periodic(const Duration(seconds: 1), call);
  }

  Text handleText() {
    if (isOK) {
      return Text(handleCodeAutoSizeText(),
          style: const TextStyle(
              fontSize: 16, color: Color(SimColor.color_button_red)));
    } else {
      return Text(handleCodeAutoSizeText(),
          style: const TextStyle(
              fontSize: 16, color: Color(SimColor.color_button_half_red)));
    }
  }

  String handleCodeAutoSizeText() {
    if (_countdownTime > 0) {
      return 'Delete $_countdownTime';
    } else {
      return 'Delete';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Urrency Unit
class UrrencyUnitDialog extends StatefulWidget {
  bool isUsdt;

  UrrencyUnitDialog({Key? key, required this.isUsdt}) : super(key: key);

  @override
  State<UrrencyUnitDialog> createState() => _UrrencyUnitDialogState();
}

class _UrrencyUnitDialogState extends State<UrrencyUnitDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Current Unit"),
                        const Divider(height: 35),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.isUsdt = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "USD",
                                style: getDefaultTextStyleTitle(),
                              ),
                              Visibility(
                                  visible: widget.isUsdt,
                                  child: Image.asset(
                                      "images/mvc_unit_select.png",
                                      width: 15,
                                      height: 15))
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                            onTap: () {
                              setState(() {
                                widget.isUsdt = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CNY",
                                  style: getDefaultTextStyleTitle(),
                                ),
                                Visibility(
                                    visible: !widget.isUsdt,
                                    child: Image.asset(
                                        "images/mvc_unit_select.png",
                                        width: 15,
                                        height: 15))
                              ],
                            )),
                        const SizedBox(height: 20),
                        DialogBottomLayout(
                            onConfirm: () {
                              Navigator.pop(context);
                              setState(() {
                                isUst = widget.isUsdt;
                                SharedPreferencesUtils.setBool(
                                    "isUst_key", isUst);
                              });
                            },
                            isVisibility: false),
                      ],
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

// Create Wallet
class CreateWalletDialog extends StatefulWidget {
  Indo indo;

  CreateWalletDialog({Key? key, required this.indo}) : super(key: key);

  @override
  State<CreateWalletDialog> createState() => _CreateWalletDialogState();
}

class _CreateWalletDialogState extends State<CreateWalletDialog> {
  bool isNew = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Create/Switch Wallet"),
                        const Divider(height: 35),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isNew = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Switch Wallet",
                                style: getDefaultTextStyleTitle(),
                              ),
                              Visibility(
                                  visible: isNew,
                                  child: Image.asset(
                                      "images/mvc_unit_select.png",
                                      width: 15,
                                      height: 15))
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isNew = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Create a new Wallet",
                                  style: getDefaultTextStyleTitle(),
                                ),
                                Visibility(
                                    visible: !isNew,
                                    child: Image.asset(
                                        "images/mvc_unit_select.png",
                                        width: 15,
                                        height: 15))
                              ],
                            )),
                        const SizedBox(height: 20),
                        DialogBottomLayout(
                            onConfirm: () {
                              Navigator.pop(context);
                              setState(() {
                                if (isNew) {
                                  addMvcWallet(widget.indo);
                                } else {
                                  // widget.indo.createWallet();
                                }
                              });
                            },
                            isVisibility: false),
                      ],
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

//  BackUpWallet
class BackUpWalletDialog extends StatelessWidget {
  const BackUpWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          // decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Backup Wallet"),
                        const Divider(height: 35),
                        Row(
                          children: const [
                            Text(
                              "Mnemonic Phrase",
                              style: TextStyle(color: Color(0xff606266)),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          myWallet.mnemonic,
                          style: getDefaultTextStyle(),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text(
                              "Derivation Path",
                              style: TextStyle(color: Color(0xff606266)),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text("m/44'/${myWallet.path}'/0'",
                                style: getDefaultTextStyle())
                          ],
                        ),
                        //这里写2个 Button
                        DialogBottomLayout(
                            onConfirm: () {
                              Navigator.pop(context);
                            },
                            isVisibility: false),
                      ],
                    ),
                  )),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

// Disclaimer
class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          // decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Disclaimer"),
                        const SizedBox(height: 30),
                        Text(
                          "Use of this wallet is at your own risk and discretion. "
                          "The wallet is not liable for any losses incurred as a result of using the wallet. ",
                          style: getDefaultTextStyle(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "The wallet does not guarantee the continuity and stability of its functions and services, "
                          "and may be interrupted or terminated due to force majeure, hacker attacks, technical failures, policy changes, or other factors. ",
                          style: getDefaultTextStyle(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Users should comply with local laws and regulations, "
                          "and the wallet is not responsible for any consequences resulting from users' violation of laws and regulations.  ",
                          style: getDefaultTextStyle(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Users should properly safeguard their private keys and mnemonic phrases, "
                          "and bear any losses incurred due to the loss or theft of private keys or mnemonic phrases.",
                          style: getDefaultTextStyle(),
                        ),
                        DialogBottomLayout(
                            onConfirm: () {
                              Navigator.pop(context);
                            },
                            isVisibility: false),
                      ],
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressDialog extends StatefulWidget {
  bool isShow;

  ProgressDialog({Key? key, required this.isShow}) : super(key: key);

  @override
  State<ProgressDialog> createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.isShow,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              child: const CircularProgressIndicator(
                  // backgroundColor: Colors.white,
                  // valueColor:  new AlwaysStoppedAnimation<Color>(Color(SimColor.color_button_blue)),
                  ),
            ),
          ),
        ));
  }
}

class EditWalletDialog extends StatefulWidget {
  const EditWalletDialog({Key? key}) : super(key: key);

  @override
  State<EditWalletDialog> createState() => _EditWalletDialogState();
}

class _EditWalletDialogState extends State<EditWalletDialog> {
  TextEditingController walletNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Edit Wallet"),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/input.png"),
                                  fit: BoxFit.fill)),
                          child: TextField(
                            decoration: InputDecoration(
                                // hintText: "m/44'/10001'/0'",
                                hintText: myWallet.name,
                                border: InputBorder.none),
                            controller: walletNameController,
                          ),
                        ),
                        const SizedBox(height: 20),
                        //这里写2个 Button
                        DialogBottomLayout(
                            onConfirm: () {
                              Navigator.pop(context);
                              setState(() {
                                if (walletNameController.text.isNotEmpty) {
                                  myWallet.name = walletNameController.text;
                                  showToast("Success");
                                  SqWallet sqWallet=SqWallet();
                                  sqWallet.updateDefaultData(myWallet);
                                  walletName=myWallet.name;
                                  // changeWalletInfo(myWallet);
                                }
                              });
                            },
                            isVisibility: false),
                      ],
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

//flutter
class SimWebView extends StatefulWidget {
  final WebViewController webViewController;

  const SimWebView(this.webViewController, {Key? key}) : super(key: key);

  @override
  State<SimWebView> createState() => _SimWebViewState(webViewController);
}

class _SimWebViewState extends State<SimWebView> {
  final WebViewController _webViewController;

  _SimWebViewState(this._webViewController);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadHtmlFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: SizedBox(
        width: 100,
        height: 100,
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    // String url = "";
    // if (Platform.isAndroid) {
    //   url = "file:///android_asset/flutter_assets/files/meta-mvc.html";
    // } else if (Platform.isIOS) {
    //   url = "file://Frameworks/App.framework/flutter_assets/files/meta-mvc.html";
    // }
    // String fileHtmlContent = await rootBundle.loadString(url);

    // String fileHtmlContent = await rootBundle.loadString("files/meta-mvc.html");
    // _webViewController?.loadHtmlString(fileHtmlContent);

    _webViewController.loadFlutterAsset("files/meta-mvc.html");
    String jsContent =
        await rootBundle.loadString("files/metaContract.iife.js");
    _webViewController.runJavaScript(jsContent);
  }
}

class DialogTitleLayout extends StatelessWidget {
  final String title;

  const DialogTitleLayout({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: getDefaultTextStyleTitle()),
    );
  }
}



//  Check Version
class CheckVersionDialog extends StatefulWidget {

  String url;

  CheckVersionDialog({Key? key,required this.url}) : super(key: key);

  @override
  State<CheckVersionDialog> createState() => _CheckVersionDialogState();
}

class _CheckVersionDialogState extends State<CheckVersionDialog> {

  bool isAsk=true;


  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          width: double.infinity,
          // decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,20,20,10),
                    child: Column(
                      children: [
                        const DialogTitleLayout(title: "Version Check"),
                        const Divider(height: 35),
                        Text(
                          "Have an updated version go to download ?",
                          style: getDefaultTextStyle(),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(isAsk){
                                isAsk=false;
                              }else{
                                isAsk=true;
                              }
                              SharedPreferencesUtils.setBool("ask_key", isAsk);
                            });
                          },
                          child:   Row(
                            children: [
                              Image.asset(isAsk==true?
                                  "images/mvc_normal_checkbox.png": "images/mvc_select_checkbox.png",
                                  width: 20,
                                  height: 20),
                              const SizedBox(width: 10),
                              const Text("Don't  ask me again .")
                            ],
                          ),

                        ),
                        //这里写2个 Button
                        DialogBottomLayout(
                            onConfirm: () {
                              Navigator.pop(context);
                              //Update
                              // doCheckVersion();
                              launchUrl(widget.url);
                            },
                            isVisibility: true),
                      ],
                    ),
                  )),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}




// ignore: must_be_immutable
class DialogBottomLayout extends StatefulWidget {
  bool isVisibility;
  void Function()? onConfirm;

  DialogBottomLayout(
      {Key? key, required this.onConfirm, required this.isVisibility})
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
                    onPressed: widget.onConfirm,
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
