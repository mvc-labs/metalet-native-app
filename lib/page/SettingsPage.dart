import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mvcwallet/page/SimpleDialog.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../main.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';
import 'RequestPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void refreshData() {
    if (myWalletList.isEmpty) {
      deleteWallet();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Padding(
    //     padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
    //     child: Column(
    //       children: const [TitleBack("Wallet 1"), SettingsContent()],
    //     ),
    //   ),
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        // return const SettingsPage();
                        return const HomePage();
                      }));
                    },
                    child: Row(
                      children: [
                        Image.asset("images/mvc_back_icon.png",
                            width: 20, height: 22),
                        const SizedBox(width: 5),
                        const Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(SimColor.deaful_txt_color)),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        walletName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(SimColor.deaful_txt_color),
                        ),
                      ),
                    )),
                SizedBox(
                    width: 44,
                    height: 44,
                    child: TextButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return const DeleteWalletDialog();
                              }).then((value) => refreshData());
                        },
                        child: Image.asset("images/mvc_wallet_delete_icon.png",
                            width: 22, height: 22))),
                const SizedBox(width: 5),
                SizedBox(
                  height: 44,
                  width: 44,
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const EditWalletDialog();
                            }).then((value) {
                          setState(() {
                            walletName = myWallet.name;
                          });
                        });
                      },
                      child: Image.asset("images/mvc_edit_icon.png",
                          width: 22, height: 22)),
                )
              ],
            ),
            const SettingsContent()
          ],
        ),
      ),
    );
  }
}

class SettingsContent extends StatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  String notice = "USD";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isUst) {
      notice = "USD";
    } else {
      notice = "CNY";
    }
  }

  void setData() {
    if (isUst) {
      notice = "USD";
    } else {
      notice = "CNY";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return UrrencyUnitDialog(
                      isUsdt: isUst,
                    );
                  }).then((value) {
                setState(() {
                  setData();
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current Unit",
                  style: getDefaultTextStyle(),
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return UrrencyUnitDialog(
                              isUsdt: isUst,
                            );
                          }).then((value) {
                        setState(() {
                          setData();
                        });
                      });
                    },
                    child: Row(children: [
                      // Text(isUst?"USD":"CNY", style: getDefaultTextStyle()),
                      Text(notice, style: getDefaultTextStyle()),
                      const SizedBox(width: 5),
                      Image.asset("images/mvc_wallet_more_icon.png",
                          width: 10, height: 10),
                    ]),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              // _authenticateMe();

              if (isFingerCan) {
                authenticateMe().then((value) {
                  if (value) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const BackUpWalletDialog();
                        });
                  }
                });
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const BackUpWalletDialog();
                    });
              }
            },
            child: Row(
              children: [
                Text(
                  "Backup Wallet",
                  style: getDefaultTextStyle(),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              authenticateMe().then((value) {
                if (value) {
                  setState(() {
                    if (isFingerCan) {
                      isFingerCan = false;
                    } else {
                      isFingerCan = true;
                    }
                    SharedPreferencesUtils.setBool("key_finger", isFingerCan);
                  });
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enable fingerprint verification",
                    style: getDefaultTextStyle(),
                  ),
                  Image.asset(
                      isFingerCan
                          ? "images/set_switch_on.png"
                          : "images/set_switch_off.png",
                      width: 30,
                      height: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const DisclaimerDialog();
                  });
            },
            child: Row(
              children: [
                Text(
                  "Disclaimer",
                  style: getDefaultTextStyle(),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () async {
              // PackageInfo pack = await PackageInfo.fromPlatform();
              // String num = pack.buildNumber;
              // String versionName = pack.version;
              // print("code:" + num);
              // _launchUrl("https://api.show3.io/install/show3.apk");
              //goolepay
              // doCheckVersion(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(visible: isNoGopay, child: const Text("Check Version")),
                SizedBox(
                  child: Text(
                    "v $versionName  ",
                    style: getDefaultTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
    // if (!await launchUrl(Uri.parse(url))) {
    //   throw Exception('Could not launch $url');
    // }
  }

// Future<void> _authenticateMe() async {
//   bool authenticated = false;
//   try {
//     authenticated = await _localAuthentication.authenticate(
//       localizedReason: "Please verify your fingerprints", // 消息对话框
//       options: const AuthenticationOptions(  biometricOnly: true,
//           useErrorDialogs: true, stickyAuth: true),
//     );
//     setState(() {
//       isFingerCan=authenticated;
//       // _message = authenticated ? "Authorized" : "Not Authorized";
//       // print("$_message");
//       if(isFingerCan){
//         showDialog(context: context, builder: (context){
//           return const BackUpWalletDialog();
//         });
//       }
//     });
//   } catch (e) {
//     print(e);
//   }
//   if (!mounted) return;
// }
}
