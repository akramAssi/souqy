import 'package:flutter/material.dart';
import 'package:souqy/res/string.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../res/color.dart';
import '../res/style.dart';

class SouqySearchFiled extends StatefulWidget with SouqyFormFieldStyle {
  final void Function(String) onChange;
  final FocusNode focusNode;
  final controller;
  SouqySearchFiled({
    key,
    this.onChange,
    this.controller,
    @required this.focusNode,
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
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: TextInputAction.next,
        cursorColor: fontColor,
        style: TextStyle(fontSize: 17, color: fontColor),
        decoration: widget.searchDecoration,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: Validators.required(Strings.requiredField(Strings.make)),
        onChanged: (value) {
          widget.onChange(value);
        },
      ),
    );
  }
}
