import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqySubmitBotton extends StatelessWidget {
  // final String lable;
  // final VoidCallback onPress;
  // const SouqySubmitBotton(
  //     {Key key, @required this.lable, @required this.onPress})
  //     : super(key: key);
  final VoidCallback onPress;
  final String label;
  final double height;
  final double fontSize;
  const SouqySubmitBotton(
      {Key key,
      @required this.onPress,
      @required this.label,
      this.height = 40,
      this.fontSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 61.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: backgroundColor,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          onPrimary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
    );
  }
}
