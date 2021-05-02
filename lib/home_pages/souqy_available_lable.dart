import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyAvailableLable extends StatelessWidget {
  SouqyAvailableLable({
    Key key,
    @required this.available,
    @required this.size,
    @required this.isCard,
  }) : super(key: key);

  final Size size;
  final bool available;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    // BorderRadiusGeometry radius =

    return Container(
      width: 60,
      height: 23,
      decoration: BoxDecoration(
        borderRadius: isCard == true
            ? BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
            : BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
    );
  }
}
