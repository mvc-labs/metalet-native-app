


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvcwallet/utils/SimColor.dart';

Widget  getThemeButton(BuildContext context,String btnContent,{Function? function}){
  var size = MediaQuery.of(context).size;
  double width = size.width;
  double height = size.height;
  return  Container(
    width: width-20,
    height: 45,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(SimColor.color_button_blue)
    ),
    child: InkWell(
      onTap: (){
        function!();
      },
      child:Align(
        alignment: Alignment.center,
        child:  Text(btnContent,style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
    ),
  );
}