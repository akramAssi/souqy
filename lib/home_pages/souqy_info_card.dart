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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: size.width / 17,
                child: AutoSizeText(
                  make,
                  maxLines: 1,
                  minFontSize: 5,
                  maxFontSize: 40,
                  style: TextStyle(
                    fontSize: size.width / 22,
                    color: fontColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: size.width / 18,
                child: AutoSizeText(
                  model,
                  maxLines: 1,
                  minFontSize: 5,
                  style: TextStyle(
                    fontSize: size.width / 23,
                    color: fontColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          // alignment: Alignment(-5, 0),
          padding: EdgeInsets.only(right: 10, top: 7, bottom: 7, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            color: alertColor,
          ),
          child: Text(
            '₪ $price',
            style: TextStyle(
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? size.width / 24
                      : size.width / 30,
              color: backgroundColor,
            ),
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

    return Row(
      children: [
        Container(
          // width: 70,
          // height: 23,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
        ),
      ],
    );
  }
}
