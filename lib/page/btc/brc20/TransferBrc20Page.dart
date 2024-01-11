import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/page/RequestBtcPage.dart';
import 'package:mvcwallet/page/btc/brc20/InscribeBrcPage.dart';
import 'package:mvcwallet/page/btc/brc20/SendBrcPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../../../bean/btc/Brc20Able.dart';

class TransferBrc20Page extends StatefulWidget {

  Brc20Able? brc20able;

  TransferBrc20Page({Key? key, required this.brc20able}) : super(key: key);

  @override
  State<TransferBrc20Page> createState() => _TransferBrc20PageState();
}

class _TransferBrc20PageState extends State<TransferBrc20Page> {
  TokenBalance? tokenBalance;
  List<TransferableList>? transferableList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tokenBalance = widget.brc20able!.data!.tokenBalance!;
    transferableList = widget.brc20able!.data!.transferableList;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TitleBack("Transfer"),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transfer amount",
                style: getDefaultGrayTextStyle16(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${tokenBalance!.transferableBalance} ${tokenBalance!.ticker!.toUpperCase()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(SimColor.deaful_txt_color),
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "TRANSFER Inscriptions (${transferableList!.length})",
                style: getDefaultGrayTextStyle16(),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: transferableList!.length>0?true:false,
                child:     Container(
                height: 140,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: transferableList!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: getListItemLayout),
              ),),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                 if(num.parse(tokenBalance!.availableBalance!)>0){
                   Navigator.of(context)
                       .push(CupertinoPageRoute(builder: (BuildContext builder) {
                     return InscribeBrcPage(tokenBalance:tokenBalance!,);
                   }));
                 }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: const Color(SimColor.gray_txt_color_border),
                          width: 0.5)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Inscribe TRANSFER",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(SimColor.deaful_txt_color),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [

                          Text(
                            "Available ",
                            // "Available 2000",
                            style: getDefaultGrayTextStyle16(),
                          ),

                          Text(
                            "${tokenBalance!.availableBalanceSafe}",
                            // "Available 2000",
                            style: getDefaultTextStyle(),
                          ),
                         Visibility(
                           visible:num.parse(tokenBalance!.availableBalanceUnSafe!)>0?true:false ,
                           // visible:true ,
                           child:  Text(
                           " + ${tokenBalance!.availableBalanceUnSafe} ",
                           // "+ 1000 ",
                           style: getDefaultGrayTextStyle16(),
                         ),),
                          Text(
                            " ${tokenBalance!.ticker!.toUpperCase()}",
                            style: getDefaultTextStyle(),
                          )
                        ],
                      ),

                      // Text(
                      //   num.parse(tokenBalance!.availableBalanceUnSafe!)>0?"Available ${tokenBalance!.availableBalance} + ${tokenBalance!.availableBalanceUnSafe} ${tokenBalance!.ticker!.toUpperCase()}":"Available ${tokenBalance!.availableBalance} ${tokenBalance!.ticker!.toUpperCase()}",
                      //   // "Available ${tokenBalance!.availableBalance} ${tokenBalance!.ticker!.toUpperCase()}",
                      //   style: getDefaultGrayTextStyle16(),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // "* To send BRC-20, you have to inscribe a TRANSFER inscription first",
              // style: getDefaultGrayTextStyle16(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "* To send BRC-20, you have to inscribe a TRANSFER inscription first",
                      style: getDefaultGrayTextStyle16(),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget getListItemLayout(BuildContext context, int index) {
    TransferableList transferable=transferableList![index];
    return  InkWell(
      onTap: (){
        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
          return SendBrcPage(transferable: transferable);
        }));
      },
      child:  Container(
        margin: index == 0
            ? const EdgeInsets.fromLTRB(0, 10, 5, 10)
            : const EdgeInsets.fromLTRB(5, 10, 5, 10),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        height: 140,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Color(SimColor.gray_txt_color_border),width: 0.7),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              transferable.ticker!.toUpperCase(),
              style: getDefaultGrayTextStyle16(),
            ),
            Expanded(
              child: Text(""),),
            Text(
              transferable!.amount!,
              style: TextStyle(
                  color: Color(SimColor.deaful_txt_color),
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: Text(""),),
            Container(
              width: 120,
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
              decoration: BoxDecoration(
                color: Color(SimColor.color_button_blue),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2),bottomRight: Radius.circular(2)),
              ),
              child:  Text(
                "#${transferable.inscriptionNumber}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
