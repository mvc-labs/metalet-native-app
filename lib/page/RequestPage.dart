import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/utils/Constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: const [TitleBack("Request"), SimQrWidgit()],
        ),
      ),
    );
  }
}

class SimQrWidgit extends StatefulWidget {
  const SimQrWidgit({Key? key}) : super(key: key);

  @override
  State<SimQrWidgit> createState() => _SimQrWidgitState();
}

class _SimQrWidgitState extends State<SimQrWidgit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        QrImage(size: 225, data: myWallet.address),
        const SizedBox(height: 30),
        TextButton(
          onPressed: () {
            ClipboardData data =   ClipboardData(text:myWallet.address);
            Clipboard.setData(data);
            showToast("Copy Address");
          },
          child: Center(
            child: Row(children: [
             const Expanded(
                flex: 1,
                child: Text(""),
              ),
              Text(myWallet.address, style: getDefaultTextStyle()),
              const SizedBox(width: 5),
              Image.asset("images/add_icon_copy.png", width: 18, height: 20),
              const Expanded(
                flex: 1,
                child: Text(""),
              ),
            ]),
          ),
        )
      ],
    );
  }
}

class TitleBack extends StatefulWidget {
  final String title;

  const TitleBack(this.title, {Key? key}) : super(key: key);

  @override
  State<TitleBack> createState() => _TitleBackState();
}

class _TitleBackState extends State<TitleBack> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(CupertinoPageRoute(builder: (BuildContext context) {
                  // return const SettingsPage();
                  return  HomePage();
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("images/mvc_back_icon.png",
                      width: 22, height: 22),
                  const SizedBox(width: 5),
                  const Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 15, color: Color(SimColor.deaful_txt_color)),
                  ),
                ],
              )),
        ),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(SimColor.deaful_txt_color),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(""),
        )
      ],
    );
  }
}


class TitleBack2 extends StatefulWidget {
  final String title;
  void Function()? onPressed;

  TitleBack2(this.title, {Key? key,this.onPressed}) : super(key: key);

  @override
  State<TitleBack2> createState() => _TitleBackState2();
}

class _TitleBackState2 extends State<TitleBack2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextButton(
              onPressed: widget.onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("images/mvc_back_icon.png",
                      width: 22, height: 22),
                  const SizedBox(width: 5),
                  const Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 15, color: Color(SimColor.deaful_txt_color)),
                  ),
                ],
              )),
        ),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(SimColor.deaful_txt_color),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(""),
        )
      ],
    );
  }
}
