import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mvcwallet/utils/SimColor.dart';

TextStyle getDefaultTextStyle() {
  return const TextStyle(
      fontSize: 15,
      color: Color(SimColor.deaful_txt_color),
      decoration: TextDecoration.none);
}

TextStyle getDefaultTextStyleTitle() {
  return const TextStyle(
      fontSize: 15,
      color: Color(SimColor.deaful_txt_color),
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold
  );
}
