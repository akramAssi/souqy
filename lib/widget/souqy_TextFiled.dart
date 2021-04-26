import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyTextField extends StatelessWidget {
  final String lable;
  final TextEditingController controller;

  SouqyTextField({Key key, @required this.lable, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyle(
            color: primeCOLOR,
            fontFamily: "Arial",
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 2.5,
        ),
        TextField(
          controller: controller,
          textAlign: TextAlign.right,
          //  controller: _textEdittingControler_bookName,
          decoration: new InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.zero,
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          )),
        ),
      ],
    );
  }
}
