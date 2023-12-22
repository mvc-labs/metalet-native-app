import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mvcwallet/utils/SimColor.dart';

TextStyle getDefaultTextStyle() {
  return const TextStyle(
      fontSize: 15,
      color: Color(SimColor.deaful_txt_color),
      decoration: TextDecoration.none);
}

TextStyle getDefaultTextStyle1() {
  return const TextStyle(
      fontSize: 16,
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

TextStyle getDefaultGrayTextStyle() {
  return const TextStyle(
      fontSize: 15,
      color: Color(SimColor.deaful_gray_txt_color),
      decoration: TextDecoration.none);
}

TextStyle getDefaultGraySmallTextStyle() {
  return const TextStyle(
      fontSize: 13,
      color: Color(SimColor.deaful_gray_txt_color),
      decoration: TextDecoration.none);
}


//Fee
TextStyle getDefaultFeeTextStyleTitle() {
  return const TextStyle(
      fontSize: 15,
      color: Color(SimColor.deaful_txt_color),
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold
  );

}


TextStyle getSelectFeeTextStyleTitle() {
  return const TextStyle(
      fontSize: 15,
      color: Colors.white,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold
  );
}





TextStyle getDefaultFeeTextStyle() {
  return const TextStyle(
      fontSize: 14,
      color: Color(SimColor.deaful_txt_color),
      decoration: TextDecoration.none);
}



TextStyle getSelectFeeTextStyle() {
  return const TextStyle(
      fontSize: 14,
      color: Colors.white,
      decoration: TextDecoration.none);
}

