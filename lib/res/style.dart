import 'package:flutter/material.dart';

import 'color.dart';

mixin SouqyTextfieldStyle {
  BorderRadius radius = BorderRadius.circular(20);
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
          borderRadius: radius,
        ),
        //set border in normal mode
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: primeCOLOR),
        ),
        //set border in foucus mode
      );
  OutlineInputBorder get souqyFocusBorder => OutlineInputBorder(
        borderSide: BorderSide(color: primeCOLOR),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.zero,
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      );
  OutlineInputBorder get souqyEnableBorder => OutlineInputBorder(
        borderSide: BorderSide(color: borderTextfieldColor),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.zero,
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      );
}
