import 'package:flutter/material.dart';

class SouqySubmitBotton extends StatelessWidget {
  // final String lable;
  // final VoidCallback onPress;
  // const SouqySubmitBotton(
  //     {Key key, @required this.lable, @required this.onPress})
  //     : super(key: key);
  final VoidCallback onPress;
  const SouqySubmitBotton({Key key, @required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 61.0),
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(fontSize: 11),
          ),
        ),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
    );
  }
}
