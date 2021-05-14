import 'package:flutter/cupertino.dart';

class CardInfo {
  String idAds;
  String make;
  String model;
  int price;
  int year;
  String origin;
  String fuel;
  bool available;
  String thumbnailUrl;
  CardInfo(
      {@required this.idAds,
      @required this.make,
      @required this.model,
      @required this.price,
      @required this.year,
      @required this.origin,
      @required this.fuel,
      @required this.available,
      @required this.thumbnailUrl});
}
