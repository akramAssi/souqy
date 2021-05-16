import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqySubmitBotton extends StatelessWidget {
  // final String label;
  // final VoidCallback onPress;
  // const SouqySubmitBotton(
  //     {Key key, @required this.label, @required this.onPress})
  //     : super(key: key);
  final VoidCallback onPress;
  final String label;
  final double height;
  final double fontSize;
  final icon;
  const SouqySubmitBotton(
      {Key key,
      @required this.onPress,
      @required this.label,
      this.height = 40,
      this.fontSize = 17,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (icon == null) {
      content = ElevatedButton(
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: backgroundColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 61.0),
          onPrimary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      );
    } else {
      content = ElevatedButton.icon(
        onPressed: onPress,
        icon: Image.asset(
          icon,
          color: backgroundColor,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: backgroundColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 61.0),
          onPrimary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      child: content,
    );
  }
}
