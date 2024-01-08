import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/bean/btc/Brc20PreDataBean.dart';
import 'package:mvcwallet/btc/Crypt.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/btc/brc20/Brc20JsonBean.dart';
import 'package:mvcwallet/page/btc/brc20/InscribeBrcPrePage.dart';
import 'package:mvcwallet/utils/SimStytle.dart';
import '../../../bean/btc/Brc20Able.dart';
import '../../../bean/btc/SendBrc20DataBean.dart';
import '../../../btc/CommonUtils.dart';
import '../../../constant/SimContants.dart';
import '../../../utils/SimColor.dart';
import '../../RequestBtcPage.dart';

class InscribeBrcPage extends StatefulWidget {

  int chooseNum = 1;
  int fee_bg_color = 0xff171AFF;
  int fee_colors_w = 0xffffffff;
  TextEditingController customSatVb = TextEditingController();
  TextEditingController inScribeNumController = TextEditingController();


  int colors = 0xffCBCDD6;
  bool isOK=false;
  TokenBalance tokenBalance;

  InscribeBrcPage({Key? key,required this.tokenBalance}) : super(key: key);

  @override
  State<InscribeBrcPage> createState() => _InscribeBrcPageState();
}

class _InscribeBrcPageState extends State<InscribeBrcPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBtcUtxo();
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
          title: const TitleBack("Inscribe Transfer"),
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
                  Expanded(flex: 1, child: SizedBox()),
                  Text(
                    "Balance ${widget.tokenBalance.availableBalanceSafe} ${widget.tokenBalance.ticker!.toUpperCase()}",
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
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          ],
                          keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                              hintText: "0",
                              border: InputBorder.none),
                          //改变输入的文本信息
                          onChanged: (value) {
                            setState(() {
                              if (value.toString().isNotEmpty) {
                                widget.isOK = true;
                                widget.colors = 0xff171AFF;
                              } else {
                                widget.isOK = false;
                                widget.colors = 0xffCBCDD6;
                              }

                              if(value.toString().isNotEmpty){
                                num inputnum=num.parse(value.toString());
                                if(inputnum>num.parse(widget.tokenBalance.availableBalanceSafe!)){
                                  widget.inScribeNumController.clear();
                                }
                              }
                            });
                          },
                          controller: widget.inScribeNumController,
                        ),
                      ),
                    ),
                    // Image.asset("images/mvc_scan_icon.png",
                    //     width: 20, height: 20),

                    //TODO scan
                    /* TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return const ScanPage();
                      }));
                    },
                    child: Image.asset("images/mvc_scan_icon.png",
                        width: 20, height: 20),
                  ),*/
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
                      nextInscribeBrc();
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

    if(feedRate!>0&&widget.inScribeNumController.text.isNotEmpty){
      if(num.parse(widget.inScribeNumController.text)>0){
        Brc20JsonBean brc20jsonBean=Brc20JsonBean(p: "brc-20",op: "transfer",tick: widget.tokenBalance.ticker,amt: widget.inScribeNumController.text);
        var jsonString=jsonEncode(brc20jsonBean.toJson());
        print("转换："+jsonString);
        String base64String=encodeBase64(jsonString);
        print("转换base64String ："+base64String);
        List<Files> filesList=[];
        Files files=Files(dataURL: base64String,filename:jsonString);
        filesList.add(files);
        SendBrc20DataBean brc20dataBean=SendBrc20DataBean(feeRate:feedRate, net: "livenet",receiveAddress: myWallet.btcAddress,files: filesList,addressType: 1);

        sendPreBrc20(brc20dataBean,brc20jsonBean);

      }
    }
  }


  // livenet
  void sendPreBrc20(SendBrc20DataBean brc20dataBean,Brc20JsonBean brc20jsonBean) async {
    Dio dio = new Dio();
    ///发起post请求
    var jsonString=jsonEncode(brc20dataBean.toJson());
    print("jsonString1111 "+jsonString);
    Response response = await  dio.post(BTC_BRC20_PRE_URL,data: jsonString);
    var data = response.data.toString();
    print("inscir "+data);
    if(response.statusCode==HttpStatus.ok){
      Brc20PreDataBean brc20preDataBean=Brc20PreDataBean.fromJson(response.data);
      Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext builder){
        return InscribeBrcPrePage(brc20preDataBean: brc20preDataBean, brc20jsonBean: brc20jsonBean);
      }));

    }


  }
}
