import 'package:flutter/material.dart';
import 'package:mvcwallet/utils/SimColor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Container(
                child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("data"),
            Text("good"),
            Text("good"),
            Text("good"),
            Text("good")
          ],
        ))),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: const BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
              image: AssetImage("images/bg_img_space.png"),
            )
                // image: AssetImage("images/icon.png"),)
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Balance",
                  style: TextStyle(
                      color: Color(SimColor.deaful_txt_half_color),
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ), //SimColor.deaful_txt_color
                const Text(
                  "\$34,201.25",
                  style: TextStyle(
                      color: Color(SimColor.deaful_txt_color), fontSize: 40),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/icon.png",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "21347.32 Spacessss",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          ),
          //这里是两个 Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              //这里写2个 Button
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child:SizedBox(
                      height: 44,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(SimColor.deaful_txt_color))),
                          child: const Text("Request",style: TextStyle(fontSize: 16))),
                    )
                ),
                const SizedBox(width: 20),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: 44,
                        child:ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(SimColor.color_button_blue))),
                          child: const Text("Send",style: TextStyle(fontSize: 16)),
                        )
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
