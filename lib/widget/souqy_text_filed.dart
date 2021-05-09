import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/style.dart';

// ignore: must_be_immutable
class SouqyTextField extends StatelessWidget with SouqyTextfieldStyle {
  final String lable;
  final TextEditingController controller;
  final double height;
  final bool isReadOnly;
  final TextAlign textAlign;
  final VoidCallback onTop;
  final VoidCallback onEditingComplete;
  final bool filled;
  final double lableFontSize;
  final bool showLable;
  final FocusNode focusNode;
  final TextInputType keyboardType;
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
      this.showLable = true,
      this.focusNode,
      this.onEditingComplete,
      this.keyboardType = TextInputType.text})
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
          controller: controller,
          focusNode: focusNode,
          //controller
          textAlign: textAlign,
          readOnly: isReadOnly,
          onTap: onTop,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          inputFormatters: (keyboardType == TextInputType.number)
              ? [FilteringTextInputFormatter.allow(RegExp(r"^\d+$"))]
              : null,
          style: TextStyle(
            color: (filled == true && color != Colors.white)
                ? Colors.white
                : fontColor,
          ),
          //style text
          decoration: InputDecoration(
              fillColor: color,
              filled: filled,
              contentPadding: (height < 60)
                  ? EdgeInsets.symmetric(vertical: 3, horizontal: 13)
                  : EdgeInsets.all(20),
              enabledBorder: souqyEnableBorder,
              focusedBorder: souqyFocusBorder),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget,
    );
  }
}
