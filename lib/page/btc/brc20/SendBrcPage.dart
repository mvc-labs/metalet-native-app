import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../../bean/btc/Brc20Able.dart';
import '../../../btc/CommonUtils.dart';
import '../../../utils/SimColor.dart';
import '../../RequestBtcPage.dart';

class SendBrcPage extends StatefulWidget {

  int chooseNum = 1;
  int fee_bg_color = 0xff171AFF;
  int fee_colors_w = 0xffffffff;
  TextEditingController customSatVb = TextEditingController();
  TextEditingController addressController = TextEditingController();

  int colors = 0xffCBCDD6;
  bool isOK=false;
  TransferableList transferable;

  SendBrcPage({Key? key,required this.transferable}) : super(key: key);

  @override
  State<SendBrcPage> createState() => _SendBrcPageState();
}

class _SendBrcPageState extends State<SendBrcPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.addressController.addListener(() {
      setState(() {
        if(isNoEmpty(widget.addressController.text)){
          widget.isOK=true;
          widget. colors=0xff171AFF;
        }else{
          widget.isOK=false;
          widget. colors=0xffCBCDD6;
        }
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TitleBack("Send"),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Amount",
                    style: getDefaultTextStyle1(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/input.png"), fit: BoxFit.fill)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child:Align(
                          child: Text(
                            "${widget.transferable.amount} ${widget.transferable.ticker!.toUpperCase()}",
                            style: TextStyle(fontSize: 16),
                          ),
                          alignment: Alignment.centerLeft,
                        )
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    "Receiver",
                    style: getDefaultTextStyle(),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/input.png"), fit: BoxFit.fill)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: "Recipient's address",
                              border: InputBorder.none),
                          controller: widget.addressController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                      child: Text(
                        "Fee Rate",
                        style: getDefaultTextStyle(),
                      ))
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.chooseNum = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
                        height: 100,
                        // width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Color(SimColor.deaful_txt_color),
                                width: 0.5),
                            color: widget.chooseNum == 0
                                ? Color(widget.fee_bg_color)
                                : Color(widget.fee_colors_w)
                            // border:BoxBorder()
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              btcFeeBean!.result!.list![0].title!,
                              style: widget.chooseNum == 0
                                  ? getSelectFeeTextStyleTitle()
                                  : getDefaultFeeTextStyleTitle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${btcFeeBean!.result!.list![0].feeRate} sat/vb",
                              style: widget.chooseNum == 0
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              btcFeeBean!.result!.list![0].desc!,
                              style: widget.chooseNum == 0
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.customSatVb.text = "";
                          widget.chooseNum = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        // width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Color(SimColor.deaful_txt_color),
                                width: 0.5),
                            color: widget.chooseNum == 1
                                ? Color(widget.fee_bg_color)
                                : Color(widget.fee_colors_w)
                            // border:BoxBorder()
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              btcFeeBean!.result!.list![1].title!,
                              style: widget.chooseNum == 1
                                  ? getSelectFeeTextStyleTitle()
                                  : getDefaultFeeTextStyleTitle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${btcFeeBean!.result!.list![1].feeRate} sat/vb",
                              style: widget.chooseNum == 1
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              btcFeeBean!.result!.list![1].desc!,
                              style: widget.chooseNum == 1
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.customSatVb.text = "";
                          widget.chooseNum = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        // width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Color(SimColor.deaful_txt_color),
                                width: 0.5),
                            color: widget.chooseNum == 2
                                ? Color(widget.fee_bg_color)
                                : Color(widget.fee_colors_w)
                            // border:BoxBorder()
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              btcFeeBean!.result!.list![2].title!,
                              style: widget.chooseNum == 2
                                  ? getSelectFeeTextStyleTitle()
                                  : getDefaultFeeTextStyleTitle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${btcFeeBean!.result!.list![2].feeRate} sat/vb",
                              style: widget.chooseNum == 2
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              btcFeeBean!.result!.list![2].desc!,
                              style: widget.chooseNum == 2
                                  ? getSelectFeeTextStyle()
                                  : getDefaultFeeTextStyle(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.customSatVb.text = "";
                        widget.chooseNum = 3;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      height: 80,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: Color(SimColor.deaful_txt_color),
                              width: 0.5),
                          color: widget.chooseNum == 3
                              ? Color(widget.fee_bg_color)
                              : Color(widget.fee_colors_w)
                          // border:BoxBorder()
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Custom",
                            style: widget.chooseNum == 3
                                ? getSelectFeeTextStyleTitle()
                                : getDefaultFeeTextStyleTitle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.chooseNum == 3 ? true : false,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/input.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]")),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                                hintText: "sat/vB", border: InputBorder.none),
                            //改变输入的文本信息
                            onChanged: (value) {},
                            controller: widget.customSatVb,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      /*if (isFingerCan) {
                        authenticateMe().then((value) {
                          if (value) {
                            //正确
                            send(widget.addressController.text,
                                widget.amountController.text);
                          }
                        });
                      } else {
                        //  TODO 继续
                        send(widget.addressController.text,
                            widget.amountController.text);
                      }*/

                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Color(widget.colors);
                      }),
                    ),
                    child: const Text("Next", style: TextStyle(fontSize: 16))),
              )
            ],
            // https://docs.scrypt.io/tutorials/hello-word/
          ),
        ));
  }


  num? feedRate = 0;
  void nextInscribeBrc(){
    switch (widget.chooseNum) {
      case 0:
        feedRate = btcFeeBean!.result!.list![0].feeRate;
        break;
      case 1:
        feedRate = btcFeeBean!.result!.list![1].feeRate;
        break;
      case 2:
        feedRate = btcFeeBean!.result!.list![2].feeRate;
        break;
      case 3:
        feedRate = num.parse(widget.customSatVb.text);
        break;
    }
  }



}
