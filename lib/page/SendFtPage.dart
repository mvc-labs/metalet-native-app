import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/data/Indo.dart';

import '../bean/FtData.dart';
import '../main.dart';
import '../utils/Constants.dart';
import '../utils/MetaFunUtils.dart';
import '../utils/SimColor.dart';
import 'RequestPage.dart';
import 'SimpleDialog.dart';

class SendFtpage extends StatefulWidget {
  Items ftItem;

  SendFtpage({Key? key, required this.ftItem}) : super(key: key);

  @override
  State<SendFtpage> createState() => _SendFtpageState();
}

class _SendFtpageState extends State<SendFtpage> implements SendFtIndo{
  @override
  Widget build(BuildContext context) {
    MetaFunUtils metaFunUtils = MetaFunUtils();
    String url = metaFunUtils.getShowImageUrl(widget.ftItem.icon!);

    TextEditingController addressController=TextEditingController();
    TextEditingController amountController=TextEditingController();


    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          children: [
            TitleBack("Send ${widget.ftItem.symbol!}"),
            const SizedBox(
              height: 50,
            ),
            ClipOval(
              child: metaFunUtils.getImageContainerSize(
                  Image.network(url, fit: BoxFit.cover), 85, 85),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xff80D2D7DE),
                  )),
              child:  Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  decoration: const  InputDecoration(
                      border: InputBorder.none,
                      hintText: "Recipient's address"),
                  controller: addressController,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xff80D2D7DE),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Amount"),
                          controller: amountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          ],
                        )),
                    Text(
                      "| ${widget.ftItem.symbol!}",
                      style: const TextStyle(fontSize: 15, color: Color(0xff6a6a6c)),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Your Balance: ${widget.ftItem.balance!} ${widget.ftItem.symbol!}",
                  style: const TextStyle(fontSize: 14, color: Color(0xff6a6a6c)),
                )
              ],
            ),
            const SizedBox(height: 50),
           Row(
             children: [
               Expanded(
                 flex: 1,
                 child: ElevatedButton(
                   onPressed: () {
                     if(amountController.value.text.isNotEmpty&&addressController.value.text.isNotEmpty){
                       showDialog(context: context, builder: (BuildContext context){
                         return ShowFtPayDialog(nftName: widget.ftItem.symbol!,amount: amountController.value.text,receiveAddress: addressController.value.text,sendFtIndo: this,);
                       });
                     }

                   },
                   style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(
                           const Color(SimColor.color_button_blue))),
                   child: const Padding(
                     padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                     child: Text(
                       "Send",
                       style: TextStyle(color: Colors.white, fontSize: 15),
                     ),
                   ),
                 ),
               )
             ],
           ),
          ],
        ),
      ),
    );
  }

  @override
  void sendCancel() {
    // TODO: implement sendCancel
    Navigator.of(context).pop();
  }

  @override
  void sendConfirm(String sendAddress, String sendAmount) {
    // TODO: implement sendConfirm
    if(isFingerCan){
      authenticateMe().then((value) {
        if(value){
          //正确
          transFer(sendAddress,sendAmount);
        }
      });
    }else{
      //  TODO 继续
      transFer(sendAddress,sendAmount);
    }

  }


  void transFer(String sendAddress,String sendAmount){
    // double sendAmountReal=double.parse(sendAmount)*widget.ftItem.decimalNum!;
    print("decimalNum 精度： ${ widget.ftItem.decimalNum!}");
    num sendAmountReal=pow(10, widget.ftItem.decimalNum!);
    print("sendAmountReal ${sendAmountReal}");
    var valueResult=num.parse(sendAmount)*sendAmountReal;
    print("valueResult ${valueResult}");
    var amountResult = Decimal.parse(valueResult.toString()).toStringAsFixed(0);
    print("amountResult ${valueResult}");
    showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(isShow: true);
        });

    webViewController.runJavaScript(
        "transferFt('${widget.ftItem.codehash}','${widget.ftItem.genesis}','$sendAddress','$amountResult')");
    sendFtDialogData.receiveAddress=sendAddress;
    sendFtDialogData.nftName=widget.ftItem.symbol;
    sendFtDialogData.ftAmount=sendAmount;

  }


}
