import 'package:flutter/material.dart';

class KiloInputCell extends StatefulWidget {
  // final int number = 0;
  KiloInputCell({key}) : super(key: key);
  // int getValue() {
  //   return number;
  // }

  @override
  State<StatefulWidget> createState() => _KiloInputCell();
}

class _KiloInputCell extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      width: size.width / 7,
      child: TextField(
        // onChanged: (value) {
        //   if (value.isNotEmpty)
        //     widget.num = int.parse(value);
        //   else if (value.isEmpty) widget.num = 0;
        //   print(widget.num);
        // },
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        maxLength: 1,
        //keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,

        style: TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          hintText: '0',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
