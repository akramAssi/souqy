import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyAvailableLable extends StatelessWidget {
  const SouqyAvailableLable({
    Key key,
    @required this.available,
    @required this.size,
  }) : super(key: key);

  final Size size;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: size.width / 80,
      top: 25.0,
      child: Container(
        width: 60,
        height: 23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          color: available == true ? annLable : redColor,
        ),
        child: Text(
          available == true ? 'متوفر' : "مباع",
          style: TextStyle(
            fontSize: 13,
            color: available == true ? primeCOLOR : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
