import 'package:flutter/material.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/string.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../res/color.dart';
import '../res/style.dart';

class SouqySearchFiled extends StatefulWidget with SouqyFormFieldStyle {
  final void Function(String) onChange;
  final FocusNode focusNode;
  final controller;
  final VoidCallback lossFocus;
  SouqySearchFiled({
    key,
    this.onChange,
    this.controller,
    @required this.focusNode,
    this.lossFocus,
  }) : super(key: key);

  @override
  _SouqySearchFiledState createState() => _SouqySearchFiledState();
}

class _SouqySearchFiledState extends State<SouqySearchFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      constraints: BoxConstraints(minHeight: 70),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      child: Focus(
        onFocusChange: (focus) {
          if (focus == false) {
            widget.lossFocus();
          }
        },
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textInputAction: TextInputAction.next,
          cursorColor: fontColor,
          style: TextStyle(fontSize: 17, color: fontColor),
          decoration: widget.searchDecoration,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String value) {
            if (Validators.required(Strings.requiredField(Strings.make)) ==
                null) return Strings.requiredField(Strings.make);
            if (!brands.contains(value)) return "must be a brand";
            return null;
          },
          onChanged: (value) {
            widget.onChange(value);
          },
        ),
      ),
    );
  }
}
