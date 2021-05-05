import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyTextField extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final double height;
  final bool isReadOnly;
  SouqyTextField(
      {Key key,
      @required this.lable,
      @required this.controller,
      this.height = 60,
      this.isReadOnly = false})
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
            fontFamily: "Ayuthaya",
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        SizedBox(
          height: height,
          child: TextField(
              readOnly: isReadOnly,
              controller: controller,
              style: TextStyle(
                color: primeCOLOR,
                fontFamily: "Ayuthaya",
              ),
              //  controller: _textEdittingControler_bookName,
              decoration: InputDecoration(
                  contentPadding: (height < 60)
                      ? EdgeInsets.symmetric(vertical: 3, horizontal: 13)
                      : EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.zero,
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ))),
        ),
      ],
    );
  }
}
