import 'package:date_format/date_format.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/btc/CommonUtils.dart';

import '../../utils/SimColor.dart';
import '../RequestBtcPage.dart';
import '../SimpleDialog.dart';
import 'BtcSignData.dart';


class SignBtcTransactionPage extends StatefulWidget {

   BtcSignData btcSignData;

   SignBtcTransactionPage({Key? key,required this.btcSignData }) : super(key: key);

  @override
  State<SignBtcTransactionPage> createState() => _SignBtcTransactionPageState();

}

class _SignBtcTransactionPageState extends State<SignBtcTransactionPage> {

  String? allAmount;
  num? sendAmount;
  num? netWorkFee;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("转账明细："+widget.btcSignData.toString());

    sendAmount= num.parse((widget.btcSignData!.sendAmount! / 100000000)!.toStringAsFixed(8)) ;
    netWorkFee= num.parse((widget.btcSignData!.netWorkFee! / 100000000)!.toStringAsFixed(8));
    allAmount =(netWorkFee! + sendAmount!).toStringAsFixed(8).toString();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        //响应物理按键
        child:  Column(
          children: [
           const TitleBack("Sign Transaction"),
            const SizedBox(
              height: 30,
            ),
            Row(
              children:  [
             Expanded(child:    Text(
               "Spend Amount",
               style: TextStyle(
                   color: Color(SimColor.deaful_txt_color),
                   fontSize: 16),
               textAlign: TextAlign.center,
             ))
              ],
            ),const SizedBox(
              height: 20,
            ),
            Row(
              children:  [
                Expanded(child:    Text(
                  "$allAmount BTC",
                  style: TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,

                ))
              ],
            ),

            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Text(
                  "Recipient Address",
                  style: TextStyle(
                      color: Color(SimColor.gray_txt_color),
                      fontSize: 15),
                ),

              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                 widget.btcSignData.sendtoAddress!,
                  style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 14),
                ),
                Image.asset("images/add_icon_copy.png", width: 16, height: 16),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Text(
                  "NETWORK FEE",
                  style: TextStyle(
                      color: Color(SimColor.gray_txt_color),
                      fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "$netWorkFee BTC",
                  style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 15),
                )
              ],
            ),  const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  "NETWORK FEE RATE",
                  style: TextStyle(
                      color: Color(SimColor.gray_txt_color),
                      fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${widget.btcSignData.netWorkFeeRate.toString()!} sat/Vb" ,
                  style: const TextStyle(
                      color: Color(SimColor.deaful_txt_color),
                      fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child:
                    InkWell(
                      onTap: (){
                       Navigator.of(context).pop();
                      },
                      child:   Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(5)),
                            border: Border.all(
                              width: 1,
                              color: const Color(
                                  SimColor.color_button_blue),
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
                    )


                )
                ,
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ProgressDialog(isShow: true);
                            });
                        doBroadcastTransaction(context,widget.btcSignData.rawTx!,sendAmount.toString(),widget.btcSignData.sendtoAddress!);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            color: Color(SimColor.color_button_blue)),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 11, 20, 11),
                          child: Text("Confirm",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    )
                ),
              ],
            ),

          ],
        ),
      ),


    );
  }
}
