import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/style.dart';

// ignore: must_be_immutable
class SouqyFormField extends StatelessWidget with SouqyFormFieldStyle {
  final String label;
  final TextEditingController controller;
  final double height;
  final bool isReadOnly;
  final TextAlign textAlign;
  final VoidCallback onTop;
  final VoidCallback onEditingComplete;
  final bool filled;
  final double labelFontSize;
  final double fontSize;
  final bool showlabel;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool obscureText;
  final String Function(String) validator;
  final void Function(String) onChange;

  Color color = primeCOLOR;
  SouqyFormField({
    Key key,
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
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.fontSize = 16,
    this.onChange,
  }) : super(key: key);

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
      Container(
        constraints: BoxConstraints(minHeight: height),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          //controller
          // onChanged: (value) {
          //   //          setState(() {
          //   //   print(value);
          //   // });

          //   print(value);
          // },
          textAlign: textAlign,
          readOnly: isReadOnly,
          obscureText: obscureText,
          onTap: onTop,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: (keyboardType == TextInputType.number)
              ? [FilteringTextInputFormatter.allow(RegExp(r"^\d+$"))]
              : null,
          style: TextStyle(
            fontSize: fontSize,
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
              focusedErrorBorder: souqyErrorBorder,
              errorBorder: souqyErrorBorder,
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
