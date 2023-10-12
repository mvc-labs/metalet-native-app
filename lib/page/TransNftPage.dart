import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/data/Indo.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/RequestPage.dart';
import 'package:mvcwallet/page/SimpleDialog.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/MetaFunUtils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/SimColor.dart';

class TransNftpage extends StatefulWidget {
  String nftName;
  String nftIconUrl;
  String nftTokenIndex;
  String nftGenesis;
  String nftCodehash;

  TransNftpage(
      {Key? key,
      required this.nftName,
      required this.nftIconUrl,
      required this.nftTokenIndex,
      required this.nftGenesis,
      required this.nftCodehash,
      })
      : super(key: key);

  @override
  State<TransNftpage> createState() => _TransNftpageState();
}

class _TransNftpageState extends State<TransNftpage> implements SendNftIndo{

  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MetaFunUtils metaFunUtils = MetaFunUtils();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Stack(
          children: [
            Column(
              children: [
                const TitleBack("Transfers NFT"),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xff80D2D7DE),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: true,
                            // child:  metaFunUtils.getImageContainer(image))
                            child: metaFunUtils.getImageContainer(Image.network(
                                widget.nftIconUrl,
                                fit: BoxFit.cover)),
                          ),
                          const Visibility(
                            visible: true,
                            child: SizedBox(
                              width: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.nftName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color(SimColor.deaful_txt_color),
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "#${widget.nftTokenIndex}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),

                const SizedBox(
                  height: 30,
                ),

                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff80D2D7DE),
                      )
                  ),
                  child:Padding(
                    padding:  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:  TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Recipient's address"
                      ),
                      controller: addressController,
                    ),
                  ),

                )

              ],
            ),
            Positioned(
                bottom: 50,
                right: 10,
                left: 10,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {

                      if(addressController.text!.isNotEmpty){
                        showDialog(context: context, builder: (BuildContext context){
                          return ShowNftPayDialog(nftName: widget.nftName,nftIconUrl: widget.nftIconUrl,nftTokenIndex: widget.nftTokenIndex,receiveAddress:addressController.text!,sendNftIndo: this,);
                          // return ShowNftSuccessDialog(nftName: widget.nftName,nftIconUrl: widget.nftIconUrl,nftTokenIndex: widget.nftTokenIndex,receiveAddress:addressController.text!,);
                        });
                        // if(isFingerCan){
                        //   authenticateMe().then((value) {
                        //     if(value){
                        //       //正确
                        //       showDialog(context: context, builder: (BuildContext context){
                        //         return ShowNftPayDialog(nftName: widget.nftName,nftIconUrl: widget.nftIconUrl,nftTokenIndex: widget.nftTokenIndex,receiveAddress:addressController.text!,sendNftIndo: this,);
                        //       });
                        //     }else{
                        //
                        //     }
                        //   });
                        // }else{
                        //   //  TODO 继续
                        //   showDialog(context: context, builder: (BuildContext context){
                        //     return ShowNftPayDialog(nftName: widget.nftName,nftIconUrl: widget.nftIconUrl,nftTokenIndex: widget.nftTokenIndex,receiveAddress:addressController.text!,sendNftIndo: this,);
                        //     // return ShowNftSuccessDialog(nftName: widget.nftName,nftIconUrl: widget.nftIconUrl,nftTokenIndex: widget.nftTokenIndex,receiveAddress:addressController.text!,);
                        //   });
                        // }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color(SimColor.color_button_blue))),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ))
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
  void sendConfirm(String sendAddress) {
    // TODO: implement sendConfirm
    // showToast(sendAddress);

    if(isFingerCan){
      authenticateMe().then((value) {
        if(value){
          //正确
          transFer(sendAddress);
        }
      });
    }else{
      //  TODO 继续
      transFer(sendAddress);
    }

  }

  void transFer(String sendAddress){
    webViewController.runJavaScript(
        "transferNft('${widget.nftGenesis}','${widget.nftCodehash}','${widget.nftTokenIndex}','$sendAddress')");
    sendNftDialogData.receiveAddress=sendAddress;
    sendNftDialogData.nftName=widget.nftName;
    sendNftDialogData.nftTokenIndex=widget.nftTokenIndex;
    sendNftDialogData.nftIconUrl=widget.nftIconUrl;


    showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(isShow: true);
        });
  }

}
