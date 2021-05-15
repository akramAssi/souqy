import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyInfoCircleCard extends StatelessWidget {
  final String path;
  final String value;
  final Size size;

  SouqyInfoCircleCard({Key key, this.path, this.value, @required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 47,
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(
            color: borderTextfieldColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              path,
              width: 15,
              height: 15,
              color: fontColor,
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: AutoSizeText(
                value,
                maxLines: 1,
                minFontSize: 6,
                style: TextStyle(
                  fontSize: 8,
                  color: alertColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SouqyInfoCircleCardTemp extends StatelessWidget {
  SouqyInfoCircleCardTemp({
    Key key,
    this.value,
    this.path,
  }) : super(key: key);
  final String value;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            child: Container(
              alignment: Alignment(0, 1),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 6,
                  color: alertColor,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment(0, -.5),
              image: AssetImage(path),
              fit: BoxFit.none,
            )),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          width: 1,
        ),
      ),
    );
  }
}
