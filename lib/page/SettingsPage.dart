import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/page/SimpleDialog.dart';
import 'package:mvcwallet/utils/Constants.dart';
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

  void  refreshData(){
    if(myWalletList.isEmpty){
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
                        myWallet.name,
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
                        onPressed:  () async {
                          await showDialog(context: context, builder: (context){
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
                        showDialog(context: context, builder: (context){
                          return const EditWalletDialog();
                        });
                      },
                      child: Image.asset("images/mvc_edit_icon.png",
                          width: 22, height: 22)),
                )
              ],
            ),
            const SettingsContent()],
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

  String notice="USD";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(isUst){
      notice="USD";
    }else{
      notice="CNY";
    }
  }

  void  setData(){
    if(isUst){
      notice="USD";
    }else{
      notice="CNY";
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
             await showDialog(context: context, builder: (context){
                return  UrrencyUnitDialog(isUsdt: isUst,);
              }).then((value){
                setState(() {
                  setData();
                });
              });
            },
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Urrency Unit",
                  style: getDefaultTextStyle(),
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: () async {
                      await showDialog(context: context, builder: (context){
                        return  UrrencyUnitDialog(isUsdt: isUst,);
                      }).then((value){
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
            onTap: (){
              showDialog(context: context, builder: (context){
                return const BackUpWalletDialog();
              });
            },
            child:  Row(
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
            onTap: (){
              showDialog(context: context, builder: (context){
                return const DisclaimerDialog();
              });
            },
            child:  Row(
              children: [
                Text(
                  "Disclaimer",
                  style: getDefaultTextStyle(),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                "v1.0.0",
                style: getDefaultTextStyle(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
