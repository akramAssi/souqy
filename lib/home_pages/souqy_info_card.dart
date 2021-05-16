import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_available_label.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';

class SouqyInfoCard extends StatelessWidget {
  final String make;
  final String model;
  final String paymentMethod;
  final int price;
  final Size size;

  SouqyInfoCard(
      {Key key,
      this.make,
      this.model,
      this.price,
      this.size,
      this.paymentMethod})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                make,
                maxLines: 1,
                minFontSize: 5,
                maxFontSize: 40,
                style: TextStyle(
                  fontSize: size.width / 22,
                  color: fontColor,
                ),
              ),
              AutoSizeText(
                model,
                maxLines: 1,
                minFontSize: 5,
                style: TextStyle(
                  fontSize: size.width / 23,
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
                  width: size.width / 24,
                ),
              ),
              Text(
                '$price',
                style: TextStyle(
                  fontSize: size.width / 24,
                  color: backgroundColor,
                ),
              ),
              SizedBox(
                width: size.width / 25,
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        (paymentMethod != null && paymentMethod.contains(Strings.installment))
            ? SouqyInstallmentsLable(
                size: size,
              )
            : SizedBox(),
      ],
    );
  }
}

class SouqyInstallmentsLable extends StatelessWidget {
  SouqyInstallmentsLable({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    // BorderRadiusGeometry radius =

    return Container(
      // width: 70,
      // height: 23,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: borderColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Strings.installment,
          style: TextStyle(
            fontSize: 10,
            color: primeCOLOR,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
