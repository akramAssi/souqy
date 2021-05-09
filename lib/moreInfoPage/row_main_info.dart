import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class RowMainInfo extends StatelessWidget {
  const RowMainInfo({
    Key key,
    @required this.size,
    @required this.make,
    @required this.model,
    @required this.price,
  }) : super(key: key);

  final Size size;
  final String make;
  final String model;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 4,
        ),
        Text(
          make,
          style: TextStyle(
            fontSize: 25,
            color: primeCOLOR,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: size.width / 2.8),
          child: Text(
            model,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 25,
              color: primeCOLOR,
            ),
          ),
        ),
        Spacer(),
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
              SizedBox(
                width: 22,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Image.asset(
                  'images/shekel.png',
                  width: 15,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
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
