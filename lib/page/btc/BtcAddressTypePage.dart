import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/utils/Constants.dart';

import '../../bean/btc/BtcAddress.dart';
import '../../data/Indo.dart';
import '../../sqlite/SqWallet.dart';
import '../../utils/SimColor.dart';
import '../../utils/SimStytle.dart';
import '../RequestBtcPage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart' hide Wallet;


class BtcAddressTypePage extends StatefulWidget {
  Indo mainIndo;

  BtcAddressTypePage({Key? key, required this.mainIndo}) : super(key: key);

  @override
  State<BtcAddressTypePage> createState() => _BtcAddressTypePageState();
}

class _BtcAddressTypePageState extends State<BtcAddressTypePage> {
  int chooseNum = 0;
  int colors = 0xff171AFF;
  int fee_colors_w = 0xffffffff;

  List<BtcAddress> addressList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      BtcAddress btcAddress0 = BtcAddress();
      btcAddress0.addressType = 0;
      btcAddress0.addressName = "Legacy";
      btcAddress0.addressP2 = "P2PKH • m/44'/0'/0'/0/0";

      BtcAddress btcAddress1 = BtcAddress();
      btcAddress1.addressType = 1;
      btcAddress1.addressName = "Native Segwit";
      btcAddress1.addressP2 = "P2PKH • m/84'/0'/0'/0/0";

      BtcAddress btcAddress2 = BtcAddress();
      btcAddress2.addressType = 2;
      btcAddress2.addressName = "Same as MVC";
      btcAddress2.addressP2 = "P2PKH • m/44'/10001'/0'/0/0";

      String btcPath = myWallet.btcPath;
      print("object $btcPath");
      print("object ${myWallet.path}");
      if ("m/44'/0'/0'/0/0" == btcPath) {
        chooseNum = 0;
        btcAddress0.isChoose = true;
      } else if ("m/84'/0'/0'/0/0" == btcPath) {
        chooseNum = 1;
        btcAddress1.isChoose = true;
      } else if ("m/44'/236'/0'/0/0" == btcPath ||
          "m/44'/10001'/0'/0/0" == btcPath) {
        chooseNum = 2;
        btcAddress2.isChoose = true;
      }

      addressList.add(btcAddress0);
      addressList.add(btcAddress1);
      addressList.add(btcAddress2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            children: [
              const TitleBack("BTC Address Type"),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: addressList.length,
                      itemBuilder: getListItemLayout))
            ],
          ),
        ));
  }

  Widget getListItemLayout(BuildContext context, int index) {
    BtcAddress btcAddress = addressList[index];
    bool isSelect = btcAddress.isChoose;

    switch (index) {
      case 0:
        btcAddress.addressP2 = "P2PKH • m/44'/0'/0'/0/0";
        break;
      case 1:
        btcAddress.addressP2 = "P2WPKH • m/84'/0'/0'/0/0";
        break;
      case 2:
        btcAddress.addressP2 = "P2PKH • m/44'/${myWallet.path}'/0'/0/0";
        break;
    }

    return InkWell(
      onTap: () {
        print("点击的是 $index");
        setState(() {
          initAddressTypeList(index);
          BtcAddress btcAddress = addressList[index];
          String btcPath="";
          switch (index) {
            case 0:
              btcPath = "m/44'/0'/0'/0/0";
              break;
            case 1:
              btcPath = "m/84'/0'/0'/0/0";
              break;
            case 2:
              btcPath ="m/44'/${myWallet.path}'/0'/0/0";
              break;
          }

          widget.mainIndo.addWallet(myWallet.name, myWallet.mnemonic, myWallet.path,btcPath!);
          Navigator.of(context)..pop()..pop();
          // chooseNum = index;
          // btcAddress = addressList[index];
          // isSelect = btcAddress.isChoose;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        padding: const EdgeInsets.all(20),
        // width: 110,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: const Color(SimColor.deaful_txt_color), width: 0.5),
            color: isSelect ? Color(colors) : Color(fee_colors_w)
          // border:BoxBorder()
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${btcAddress.addressName}",
              style: isSelect
                  ? getSelectFeeTextStyleTitle()
                  : getDefaultFeeTextStyleTitle(),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              btcAddress!.addressP2!,
              style:
              isSelect ? getSelectFeeTextStyle() : getDefaultFeeTextStyle(),
            ),
          ],
        ),
      ),
    );
  }


  void initAddressTypeList(int select) {
    for (var o in addressList) {
      o.isChoose = false;
      if (select == o.addressType) {
        o.isChoose = true;
        chooseNum = select;
      }
    }
    print("111集合数据： " + addressList.toString());
  }

}

