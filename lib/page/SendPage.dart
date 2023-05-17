import 'package:flutter/material.dart';
import 'package:mvcwallet/main.dart';
import 'package:mvcwallet/page/RequestPage.dart';

import '../utils/SimColor.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  State<SendPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: const [
            TitleBack("Request"),
            SendPageContent()
          ],
        ),
      ),
    );
  }
}


class SendPageContent extends StatefulWidget {
  const SendPageContent({Key? key}) : super(key: key);

  @override
  State<SendPageContent> createState() => _SendPageContentState();
}

class _SendPageContentState extends State<SendPageContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          // decoration: BoxDecoration(color: Colors.red),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "images/icon.png",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Balances",
                                style: TextStyle(
                                    color:
                                    Color(SimColor.deaful_txt_half_color),
                                    fontSize: 14),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children:  [
                              Text(spaceBalance,
                                  style: const TextStyle(
                                      color: Color(SimColor.deaful_txt_color),
                                      fontSize: 18))
                            ],
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
