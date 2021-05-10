import 'package:flutter/material.dart';

import 'color.dart';

mixin SouqyFormFieldStyle {
  final BorderRadius borderRadius = BorderRadius.circular(10);
  final Radius radius = Radius.circular(10);
  //return to last TextField
  TextSelection returnToLast(controller) {
    return TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  InputDecoration get searchDecoration => InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        //icon search
        labelText: "Make",
        labelStyle: TextStyle(fontSize: 18, color: primeCOLOR),
        //prepare label
        filled: true,
        fillColor: backgroundColor,
        //set backgtound
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: borderRadius,
        ),
        //set border in normal mode
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: primeCOLOR),
        ),
        //set border in foucus mode
      );
  OutlineInputBorder get souqyFocusBorder => OutlineInputBorder(
        borderSide: BorderSide(color: primeCOLOR),
        borderRadius: BorderRadius.only(
          topRight: radius,
          topLeft: Radius.zero,
          bottomLeft: radius,
          bottomRight: radius,
        ),
      );
  OutlineInputBorder get souqyEnableBorder => OutlineInputBorder(
        borderSide: BorderSide(color: borderTextfieldColor),
        borderRadius: BorderRadius.only(
          topRight: radius,
          topLeft: Radius.zero,
          bottomLeft: radius,
          bottomRight: radius,
        ),
      );
  OutlineInputBorder get souqyErrorBorder => OutlineInputBorder(
        borderSide: BorderSide(color: alertColor),
        borderRadius: BorderRadius.only(
          topRight: radius,
          topLeft: Radius.zero,
          bottomLeft: radius,
          bottomRight: radius,
        ),
      );

  final TextStyle errorStyle =
      TextStyle(fontSize: 10, height: 1, color: alertColor);
}
