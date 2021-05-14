import 'package:souqy/model/more_info_car.dart';

import 'card_info.dart';

class Ads {
  CardInfo card;
  MoreInfoCar moreInfo;
  String idAds;
  Ads(this.idAds, this.card, this.moreInfo);

  Ads.card(
      {String idAds,
      String make,
      String model,
      int price,
      int year,
      String origin,
      String fuel,
      bool available,
      String thumbnailUrl}) {
    this.card = CardInfo(
        idAds: idAds,
        make: make,
        model: model,
        price: price,
        year: year,
        origin: origin,
        fuel: fuel,
        available: available,
        thumbnailUrl: thumbnailUrl);
  }
}
