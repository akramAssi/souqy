import 'dart:convert';

import 'package:souqy/model/card_info.dart';
import 'package:souqy/model/more_info_car.dart';

Ads adsFromJson(String str) => Ads.fromJson(json.decode(str));

String adsToJson(Ads data) => json.encode(data.toJson());

class Ads {
  Ads({
    this.cardInfo,
    this.moreInfo,
  });

  CardInfo cardInfo;
  MoreInfo moreInfo;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        cardInfo: CardInfo.fromJson(json["cardInfo"]),
        moreInfo: MoreInfo.fromJson(json["moreInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "cardInfo": cardInfo.toJson(),
        "moreInfo": moreInfo.toJson(),
      };
}
