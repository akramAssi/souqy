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

  List<int> number;

  SouqyKilometerTextField({Key key, this.number}) : super(key: key) {
    if (number == null) {
      number = [0, 0, 0, 0, 0, 0];
    }
    _controllerField1.text = number[0].toString();
    _controllerField2.text = number[1].toString();
    _controllerField3.text = number[2].toString();
    _controllerField4.text = number[3].toString();
    _controllerField5.text = number[4].toString();
    _controllerField6.text = number[5].toString();
  }

  int get kilometer {
    var y = number.join('');
    return int.parse(y);
  }

  void onPress(dynamic value) {
    number = value;
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
