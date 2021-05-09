// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:souqy/widget/kilo_input_cell.dart';

import 'dialog/Kilometer_dialog.dart';

// ignore: must_be_immutable
class SouqyKilometerTextField extends StatelessWidget {
  final TextEditingController _controllerField1 = TextEditingController();
  final TextEditingController _controllerField2 = TextEditingController();
  final TextEditingController _controllerField3 = TextEditingController();
  final TextEditingController _controllerField4 = TextEditingController();
  final TextEditingController _controllerField5 = TextEditingController();
  final TextEditingController _controllerField6 = TextEditingController();

  List<int> number = [0, 0, 0, 0, 0, 0];

  int get kilometer {
    var y = number.join('');
    return int.parse(y);
  }

  void onPress(dynamic value) {
    number = value;
    print(number);
    _controllerField1.text = value[0].toString();
    _controllerField2.text = value[1].toString();
    _controllerField3.text = value[2].toString();
    _controllerField4.text = value[3].toString();
    _controllerField5.text = value[4].toString();
    _controllerField6.text = value[5].toString();
  }

  void onTap(BuildContext context) {
    showKilometer(context: context, number: number, onPress: onPress);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        KiloInputCell(
          controller: _controllerField1,
          onTap: () {
            onTap(context);
          },
        ),
        KiloInputCell(
          controller: _controllerField2,
          onTap: () {
            onTap(context);
          },
        ),
        KiloInputCell(
          controller: _controllerField3,
          onTap: () {
            onTap(context);
          },
        ),
        KiloInputCell(
          controller: _controllerField4,
          onTap: () {
            onTap(context);
          },
        ),
        KiloInputCell(
          controller: _controllerField5,
          onTap: () {
            onTap(context);
          },
        ),
        KiloInputCell(
          controller: _controllerField6,
          onTap: () {
            onTap(context);
          },
        ),
      ],
    );
  }
}
