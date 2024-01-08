import 'package:flutter/material.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/utils/SimColor.dart';
import 'package:mvcwallet/utils/SimStytle.dart';

import '../BtcSignData.dart';

class Brc20TranPrePage extends StatefulWidget {
  BtcSignData btcSignData;

  Brc20TranPrePage({Key? key, required this.btcSignData}) : super(key: key);

  @override
  State<Brc20TranPrePage> createState() => _Brc20TranPrePageState();
}

class _Brc20TranPrePageState extends State<Brc20TranPrePage> {

  List<String> inputs=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputs=widget.btcSignData.inputUtxos!;
  }


  @override
  Widget build(BuildContext context) {

    int btcNum=int.parse(widget.btcSignData.outputUtxos![0]);
    String showOutputSat=(btcNum/100000000).toStringAsFixed(8);

    int btcChangeNum=int.parse(widget.btcSignData.changeAmount!);
    String showChangeSat=(btcChangeNum/100000000).toStringAsFixed(8);

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Inputs",
              style: getDefaultTextStyle18(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: inputs.length,
              itemBuilder: getListViewItemLayout),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Outputs",
              style: getDefaultTextStyle18(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(SimColor.color_bg_gray)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 150),
                  child: Text(
                    "${widget.btcSignData.sendtoAddress}",
                    style: getDefaultTextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "$showOutputSat BTC",
                  style: getDefaultTextStyle1(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(SimColor.color_bg_gray)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 150),
                  child: Text(myWallet.btcAddress,
                    style: getDefaultTextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "$showChangeSat BTC",
                  style: getDefaultTextStyle1(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }


  Widget getListViewItemLayout(BuildContext context,int index){

    int btcNum=int.parse(inputs[index]);
    String showSat=(btcNum/100000000).toStringAsFixed(8);

    return  Container(
      margin: index==0?const EdgeInsets.all(0):const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Color(SimColor.color_bg_gray)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 150),
            child: Text(
              myWallet.btcAddress,
              style: getDefaultTextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "$showSat BTC",
            style: getDefaultTextStyle1(),
          )
        ],
      ),
    );
  }


}
