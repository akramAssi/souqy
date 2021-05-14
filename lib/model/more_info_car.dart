import 'package:flutter/cupertino.dart';

class MoreInfoCar {
  List<String> imageList;
  int kilo;
  int passengers;
  String color;
  String gear;
  int engin;
  int oldOwner;
  List<String> feature;
  String additionalInformation;
  String publishDate;
  String userId;

  MoreInfoCar({
    @required this.imageList,
    @required this.kilo,
    @required this.passengers,
    @required this.color,
    @required this.gear,
    @required this.engin,
    @required this.oldOwner,
    @required this.feature,
    @required this.additionalInformation,
    @required this.publishDate,
    @required this.userId,
  });
}
