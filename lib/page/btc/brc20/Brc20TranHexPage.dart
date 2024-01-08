import 'package:flutter/material.dart';
import 'package:mvcwallet/utils/SimColor.dart';

import '../../../utils/SimStytle.dart';
import '../BtcSignData.dart';

class Brc20TranHexPage extends StatefulWidget {
  BtcSignData btcSignData;

  Brc20TranHexPage({Key? key, required this.btcSignData}) : super(key: key);

  @override
  State<Brc20TranHexPage> createState() => _Brc20TranHexPageState();
}

class _Brc20TranHexPageState extends State<Brc20TranHexPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Outputs",
              style: getDefaultTextStyle18(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(SimColor.color_bg_gray),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
                widget.btcSignData.rawTx!,
                style: getDefaultTextStyle()),
          )
        ],
      ),
    );
    // child: Text("02000000000101ae6b61ad08b5b37bd67e6c0dea1e4eea5ef2ef11c7ee5a5714144ab6815764100000000000ffffffff024e4b0000000000002251207246d981d34913f33a5ed61933026619807dd6425501dd81b5d5ce6de497d8996bfd04000000000016001448ac64602ad59f35cdcc5a295d3209bb91cd58250247304402206bfcf9b7754e62a9063e2ac8e3028e42c3cfef81df1e13bd5b7432b7b5a20f41022031e356b6b7050c9fbb0075b6f46d68bd5140a0ba83e3b49818a5fcba2f5b9b3a012102e6ba98f298476490e0f59d7e94900aa638114609f818107aaa84dd95ba35616500000000",style: TextStyle(
    //     fontSize: 60
    // ),),
  }
}
