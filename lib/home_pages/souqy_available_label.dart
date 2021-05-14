import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';

class SouqyAvailabellabel extends StatelessWidget {
  SouqyAvailabellabel({
    Key key,
    @required this.availabel,
    @required this.size,
    @required this.isCard,
  }) : super(key: key);

  final Size size;
  final bool availabel;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    // BorderRadiusGeometry radius =

    return Container(
      width: 70,
      height: 23,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        // borderRadius: isCard == false
        //     ? BorderRadius.only(
        //         topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
        //     : BorderRadius.only(
        //         topRight: Radius.circular(10),
        //         bottomRight: Radius.circular(10)),
        color: availabel == true ? annotationColor : alertColor,
      ),
      child: Text(
        availabel == true ? Strings.availabel : Strings.sold,
        style: TextStyle(
          fontSize: 10,
          color: availabel == true ? primeCOLOR : Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
