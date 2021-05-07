import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyTextField extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final double height;
  final bool isReadOnly;
  final TextAlign textAlign;
  final VoidCallback onTop;
  final bool filled;
  final double lableFontSize;
  final showLable;
  Color color = primeCOLOR;
  SouqyTextField(
      {Key key,
      @required this.lable,
      @required this.controller,
      this.height = 60,
      this.isReadOnly = false,
      this.textAlign = TextAlign.start,
      this.onTop,
      this.color,
      this.filled = false,
      this.lableFontSize = 14.0,
      this.showLable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widget = [];

    if (showLable) {
      widget.addAll(
        [
          Text(
            lable,
            style: TextStyle(
              color: primeCOLOR,
              fontSize: lableFontSize,
            ),
          ),
          SizedBox(
            height: 3,
          ),
        ],
      );
    }
    widget.add(
      SizedBox(
        height: height,
        child: TextField(
            textAlign: textAlign,
            readOnly: isReadOnly,
            controller: controller,
            onTap: onTop,
            style: TextStyle(
              color: (filled == true && color != Colors.white)
                  ? Colors.white
                  : primeCOLOR,
            ),
            //  controller: _textEdittingControler_bookName,
            decoration: InputDecoration(
                fillColor: color,
                filled: true,
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
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget,
    );
  }
}
