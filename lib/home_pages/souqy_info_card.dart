import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyInfoCard extends StatelessWidget {
  final String make;
  final String model;
  final int price;
  final Size size;

  SouqyInfoCard({Key key, this.make, this.model, this.price, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                make,
                style: TextStyle(
                  fontSize: 25,
                  color: fontColor,
                ),
              ),
              Text(
                model,
                style: TextStyle(
                  fontSize: 23,
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          alignment: Alignment(-5, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            color: alertColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Image.asset(
                  'images/shekel.png',
                  width: 15,
                ),
              ),
              Text(
                '$price',
                style: TextStyle(
                  fontSize: size.width / 23,
                  color: backgroundColor,
                ),
              ),
              SizedBox(
                width: 22,
              )
            ],
          ),
        ),
      ],
    );
  }
}
