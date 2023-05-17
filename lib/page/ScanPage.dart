import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/page/ScanResultPage.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:mvcwallet/utils/EventBusUtils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../main.dart';
import 'RequestPage.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: ScanQrCodePage()
          // SingleChildScrollView(
          //   child: Column(
          //     children: const [TitleBack("Scan"), ScanQrCodePage()]
          //   ),
          // )
          ),
    );
  }
}

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({Key? key}) : super(key: key);

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller?.dispose();
        controller?.pauseCamera();
        print(result.toString());
        showToast(validateInput(result?.code));
        // Get.back(result: scanData?.code);
        // EventBusUtils.instance
        //     .fire(StringContentEvent(validateInput(result?.code)));
        // EventBusUtils.instance.fire(StringContentEvent(validateInput result.code));

        Navigator.of(context).push(
            CupertinoPageRoute(builder: (BuildContext context) {
              // return  ScanPage2();
              // return const ScanResultPage(validateInput(result?.code));
              return  ScanResultPage( result: validateInput(result?.code), isScan: true,);
            }));



      });
    });
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }
}
