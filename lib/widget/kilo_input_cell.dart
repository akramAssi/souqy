import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/style.dart';

class KiloInputCell extends StatefulWidget {
  KiloInputCell({key, @required this.controller, @required this.onTap})
      : super(key: key);
  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _KiloInputCell();
}

class _KiloInputCell extends State<KiloInputCell> with SouqyTextfieldStyle {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      width: size.width / 7,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        maxLength: 1,
        readOnly: true,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        onTap: widget.onTap,
        style: TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          hintText: '0',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderTextfieldColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderTextfieldColor)),
        ),
      ),
    );
  }
}
