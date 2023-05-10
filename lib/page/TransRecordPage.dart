import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/SimColor.dart';
import '../utils/SimStytle.dart';
import 'RequestPage.dart';

class TransRecordPage extends StatefulWidget {
  const TransRecordPage({Key? key}) : super(key: key);

  @override
  State<TransRecordPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<TransRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: const [
            TitleBack("Transaction Record"),
            TransRecordContent()
          ],
        ),
      ),
    );
  }
}

class TransRecordContent extends StatefulWidget {
  const TransRecordContent({Key? key}) : super(key: key);

  @override
  State<TransRecordContent> createState() => _TransRecordContentState();
}

class _TransRecordContentState extends State<TransRecordContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      child: Column(
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
                              children: const [
                                Text("3234.485u89 Space",
                                    style: TextStyle(
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
          Container(
            width: double.infinity,
            height: 600,
            child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2023-04-29",
                    style: getDefaultTextStyle(),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(children: [
                        Text("+100 Space", style: getDefaultTextStyle()),
                        const SizedBox(width: 5),
                        Image.asset("images/icon_link.png",
                            width: 20, height: 20),
                      ]),
                    ),
                  )
                ],
              ),
              const Divider(),
            ],
          ),
          )
        ],
      ),
    );
  }
}
