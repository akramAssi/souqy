import 'package:flutter/material.dart';
import 'package:souqy/res/string.dart';
import 'car.dart';
import 'color.dart';

class SouqyStyle {
  static final Radius radius = Radius.circular(10);
  static final BorderRadius souqyBorderRadius = BorderRadius.only(
    topRight: radius,
    topLeft: Radius.zero,
    bottomLeft: radius,
    bottomRight: radius,
  );
}

mixin SouqyFormFieldStyle {
  final BorderRadius borderRadius = BorderRadius.circular(10);

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
        labelText: Strings.make,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: alertColor),
          borderRadius: borderRadius,
        ),
        errorStyle: errorStyle,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: alertColor),
          borderRadius: borderRadius,
        ),
        //set border in foucus mode
      );
  InputDecoration get searchDecorationExhibition => InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        //icon search
        labelText: 'Exhibitions name Or city',
        labelStyle: TextStyle(fontSize: 12, color: primeCOLOR),
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: alertColor),
          borderRadius: borderRadius,
        ),
        errorStyle: errorStyle,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: alertColor),
          borderRadius: borderRadius,
        ),
        //set border in foucus mode
      );
  OutlineInputBorder get souqyFocusBorder => OutlineInputBorder(
        borderSide: BorderSide(color: primeCOLOR),
        borderRadius: SouqyStyle.souqyBorderRadius,
      );
  OutlineInputBorder get souqyEnableBorder => OutlineInputBorder(
        borderSide: BorderSide(color: borderTextfieldColor),
        borderRadius: SouqyStyle.souqyBorderRadius,
      );
  OutlineInputBorder get souqyErrorBorder => OutlineInputBorder(
        borderSide: BorderSide(color: alertColor),
        borderRadius: SouqyStyle.souqyBorderRadius,
      );

  final TextStyle errorStyle =
      TextStyle(fontSize: 10, height: 1, color: alertColor);
}
