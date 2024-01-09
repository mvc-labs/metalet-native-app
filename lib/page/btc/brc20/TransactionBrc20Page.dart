import 'package:date_format/date_format.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../../../utils/SimColor.dart';
import '../../RequestBtcPage.dart';
import '../../SimpleDialog.dart';
import '../BtcSignData.dart';

class TransactionBrc20Page extends StatefulWidget {
  BtcSignData btcSignData;

  TransactionBrc20Page({Key? key, required this.btcSignData}) : super(key: key);

  @override
  State<TransactionBrc20Page> createState() => _TransactionBrc20PageState();
}

class _TransactionBrc20PageState extends State<TransactionBrc20Page> {
  String? allAmount;
  String? sendAmount;
  num? netWorkFee;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendAmount=widget.btcSignData.brc20Amt!;
    // print("转账明细："+widget.btcSignData.toString());
    //
    // sendAmount= num.parse((widget.btcSignData!.sendAmount! / 100000000)!.toStringAsFixed(8)) ;
    // netWorkFee= num.parse((widget.btcSignData!.netWorkFee! / 100000000)!.toStringAsFixed(8));
    // allAmount =(netWorkFee! + sendAmount!).toStringAsFixed(8).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        //响应物理按键
        child: Column(
          children: [
            const TitleBack("Send"),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.btcSignData.brc20Amt!,
                  style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  "From",
                  style: getDefaultGrayTextStyle16(),
                ),
                Expanded(child: Text("")),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 180),
                  child: Text(
                    myWallet.btcAddress,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 14,
                    ),
                  ),
                ),
                // Image.asset("images/add_icon_copy.png", width: 16, height: 16),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "To",
                  style: getDefaultGrayTextStyle16(),
                ),
                Expanded(child: Text("")),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 180),
                  child: Text(
                    widget.btcSignData.sendtoAddress!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 14,
                    ),
                  ),
                ),
                // Image.asset("images/add_icon_copy.png", width: 16, height: 16),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Payment Network Fee",
                  style: getDefaultGrayTextStyle16(),
                ),
                Expanded(child: Text("")),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 180),
                  child: Text(
                    "${(widget.btcSignData!.netWorkFee! / 100000000).toStringAsFixed(8)} BTC",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 15,
                    ),
                  ),
                ),
                // Image.asset("images/add_icon_copy.png", width: 16, height: 16),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              width: 1,
                              color: const Color(SimColor.color_button_blue),
                            )),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(
                                  SimColor.color_button_blue,
                                ),
                                fontSize: 15),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ProgressDialog(isShow: true);
                            });
                        doBroadcastTransaction(context,widget.btcSignData.rawTx!,sendAmount.toString(),widget.btcSignData.sendtoAddress!);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(SimColor.color_button_blue)),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 11, 20, 11),
                          child: Text("Confirm",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
