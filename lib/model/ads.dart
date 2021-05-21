// import 'dart:convert';

// import 'package:souqy/model/card_info.dart';
// import 'package:souqy/model/more_info_car.dart';

// Ads adsFromJson(String str) => Ads.fromJson(json.decode(str));

// String adsToJson(Ads data) => json.encode(data.toJson());

// class Ads {
//   Ads({
//     this.cardInfo,
//     this.moreInfo,
//   });

//   CardInfo cardInfo;
//   MoreInfo moreInfo;

//   factory Ads.fromJson(Map<String, dynamic> json) => Ads(
//         cardInfo: CardInfo.fromJson(json["cardInfo"]),
//         moreInfo: MoreInfo.fromJson(json["moreInfo"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "cardInfo": cardInfo.toJson(),
//         "moreInfo": moreInfo.toJson(),
//       };
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Ads adsFromJson(String str) => Ads.fromJson(json.decode(str));

String adsToJson(Ads data) => json.encode(data.toJson());

class Ads {
  Ads({
    this.id,
    this.make,
    this.model,
    this.price,
    this.year,
    this.origin,
    this.fuel,
    this.avaliable,
    this.paymentMethod,
    this.urlThumb,
    this.type,
    this.kilo,
    this.engineSize,
    this.passenger,
    this.color,
    this.gear,
    this.oldOwner,
    this.listImage,
    this.carFeature,
    this.additionalInformation,
    this.publishDate,
    this.downPayment,
    this.monthlyPayment,
    this.userId,
  });

  String id;
  String make;
  String model;
  int price;
  int year;
  String origin;
  String fuel;
  bool avaliable;
  String paymentMethod;
  String urlThumb;
  String type;
  int kilo;
  int engineSize;
  int passenger;
  String color;
  String gear;
  int oldOwner;
  List<String> listImage;
  List<String> carFeature;
  String additionalInformation;
  String publishDate;
  int downPayment;
  int monthlyPayment;
  String userId;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        make: json["make"],
        model: json["model"],
        price: json["price"],
        year: json["year"],
        origin: json["origin"],
        fuel: json["fuel"],
        avaliable: json["avaliable"],
        paymentMethod: json["paymentMethod"],
        urlThumb: json["urlThumb"],
        type: json["type"],
        kilo: json["kilo"],
        engineSize: json["engineSize"],
        passenger: json["passenger"],
        color: json["color"],
        gear: json["gear"],
        oldOwner: json["oldOwner"],
        listImage: List<String>.from(json["listImage"].map((x) => x)),
        carFeature: List<String>.from(json["carFeature"].map((x) => x)),
        additionalInformation: json["additionalInformation"],
        // publishDate: DateTime.parse(json["publishDate"]),
        publishDate: json["publishDate"] == null
            ? null
            : DateFormat.yMMMMd().format(json["publishDate"].toDate()),
        downPayment: json["downPayment"],
        monthlyPayment: json["monthlyPayment"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate();
    return {
      "make": make,
      "model": model,
      "price": price,
      "year": year,
      "origin": origin,
      "fuel": fuel,
      "avaliable": avaliable,
      "paymentMethod": paymentMethod,
      "urlThumb": urlThumb,
      "type": type,
      "kilo": kilo,
      "engineSize": engineSize,
      "passenger": passenger,
      "color": color,
      "gear": gear,
      "oldOwner": oldOwner,
      "listImage": List<dynamic>.from(listImage.map((x) => x)),
      "carFeature": List<dynamic>.from(carFeature.map((x) => x)),
      "additionalInformation": additionalInformation,
      "publishDate": myDateTime,
      // "publishDate": publishDate.toIso8601String(),
      "downPayment": downPayment,
      "monthlyPayment": monthlyPayment,
      "userId": userId,
    };
  }
}
