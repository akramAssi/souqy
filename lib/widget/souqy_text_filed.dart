import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/style.dart';

// ignore: must_be_immutable
class SouqyTextField extends StatelessWidget with SouqyTextfieldStyle {
  final String label;
  final TextEditingController controller;
  final double height;
  final bool isReadOnly;
  final TextAlign textAlign;
  final VoidCallback onTop;
  final VoidCallback onEditingComplete;
  final bool filled;
  final double labelFontSize;
  final bool showlabel;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  Color color = primeCOLOR;
  SouqyTextField(
      {Key key,
      @required this.label,
      @required this.controller,
      this.height = 60,
      this.isReadOnly = false,
      this.textAlign = TextAlign.start,
      this.onTop,
      this.color,
      this.filled = false,
      this.labelFontSize = 14.0,
      this.showlabel = true,
      this.focusNode,
      this.onEditingComplete,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widget = [];

    if (showlabel) {
      widget.addAll(
        [
          Text(
            label,
            style: TextStyle(
              color: primeCOLOR,
              fontSize: labelFontSize,
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
