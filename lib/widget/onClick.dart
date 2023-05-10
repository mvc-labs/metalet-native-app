import 'package:flutter/material.dart';


// ignore: must_be_immutable
class SimRaiseButton extends StatefulWidget {
   void Function()? onPressed;
   Widget widget;
   SimRaiseButton(this.widget, {super.key, this.onPressed});

  @override
  State<SimRaiseButton> createState() => _SimRaiseButtonState(widget,onPressed: onPressed);

  
}


TextButton _textButton(Widget widget,void Function()?  onPressed){
  return TextButton(onPressed: onPressed, child: widget);
}

class _SimRaiseButtonState extends State<SimRaiseButton> {
  void Function()? onPressed;
  Widget widgets;

  _SimRaiseButtonState(this.widgets, {Key? key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return _textButton(widget,onPressed);
  }


}






