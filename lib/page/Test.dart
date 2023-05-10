/*
 * @Description: 可以直接拿去用的 Widget
 */

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VercodeTimerWidget extends StatefulWidget {
  @override
  _VercodeTimerWidgetState createState() => _VercodeTimerWidgetState();
}

class _VercodeTimerWidgetState extends State<VercodeTimerWidget> {
  late Timer _timer;

  //倒计时数值
  var _countdownTime = 10;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(handleCodeAutoSizeText(),
          style: TextStyle(
              color: ThemeData().primaryColor,
              fontSize: 34)),
      onPressed: () {
        if (_countdownTime == 0) {
          startCountdown();
        }
      },
    );
  }

  String handleCodeAutoSizeText() {
    if (_countdownTime > 0) {
      return '{$_countdownTime}s后重新发送';
    } else
      return '获取验证码';
  }

  //倒计时方法
  startCountdown() {
    //倒计时时间
    _countdownTime = 60;
    final call = (timer) {
      if (_countdownTime < 1) {
        _timer.cancel();
      } else {
        setState(() {
          _countdownTime -= 1;
        });
      }
    };
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), call);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
