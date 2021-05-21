import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class RowMainInfo extends StatelessWidget {
  RowMainInfo({
    Key key,
    @required this.size,
    @required this.make,
    @required this.model,
    @required this.price,
  }) : super(key: key);

  final Size size;
  final String make;
  final String model;
  final int price;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 4,
        ),
        SizedBox(
          width: size.width * .62,
          child: AutoSizeText(
            "$make $model",
            maxFontSize: 20,
            minFontSize: 10,
            maxLines: 3,
            style: TextStyle(
              fontSize: 20,
              color: primeCOLOR,
            ),
          ),
        ),
        Spacer(),
        Container(
          alignment: Alignment(-5, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
            color: alertColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 22,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Text(
                  "$price",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Image.asset(
                'images/shekel.png',
                width: 15,
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}
