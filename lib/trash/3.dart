import 'package:souqy/model/ads.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

List<Ads> dataList = [
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Mercedes",
      model: "S-Class",
      price: 500000,
      year: 2021,
      origin: "private",
      fuel: "petrol",
      available: true,
      thumbnailUrl:
          "https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1001x565p.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "BMW",
      model: "3-Sereis",
      price: 160000,
      year: 2010,
      origin: "private",
      fuel: "petrol",
      available: true,
      thumbnailUrl:
          "https://www.auto-data.net/images/f57/BMW-3-Series-Coupe-E92-facelift-2010.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Mercedes ",
      model: "S-Class",
      price: 100000,
      year: 1997,
      origin: "private",
      fuel: "petrol",
      available: true,
      thumbnailUrl:
          "https://i.pinimg.com/originals/d6/55/9b/d6559b363584926efbad56aa362c60fa.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Mercedes ",
      model: "E-Class",
      price: 180000,
      year: 2012,
      origin: "private",
      fuel: "diesel",
      available: true,
      thumbnailUrl: "https://i.ytimg.com/vi/-kpVMRJrgOg/maxresdefault.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Hyundai ",
      model: "Tucson",
      price: 90000,
      year: 2018,
      origin: "private",
      fuel: "diesel",
      available: false,
      thumbnailUrl:
          "https://img.drivemag.net/media/default/0001/79/2018-Hyundai-Tucson-Sport-0-7353-default-large.jpeg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "skoda ",
      model: "octavia",
      price: 70000,
      year: 2014,
      origin: "taxi",
      fuel: "diesel",
      available: true,
      thumbnailUrl: "https://i.ytimg.com/vi/DPYDLMytmpY/maxresdefault.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "skoda",
      model: "fabia",
      price: 50000,
      year: 2014,
      origin: "taxi",
      fuel: "diesel",
      available: false,
      thumbnailUrl:
          "https://s.car.info/image_files/1920/skoda-fabia-combi-front-side-2-85000.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Mazda",
      model: "CX-3",
      price: 90000,
      year: 2017,
      origin: "private",
      fuel: "petrol",
      available: true,
      thumbnailUrl:
          "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2016/09/2017-Mazda-CX-3-AWD-115.jpg?fill=2:1&resize=1200:*"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Mercedes ",
      model: "sprinter",
      price: 70000,
      year: 2006,
      origin: "commercial",
      fuel: "diesel",
      available: true,
      thumbnailUrl:
          "https://autoline.co.ug/img/s/commercial-vehicle-closed-box-vanMERCEDES-BENZ-SPRINTER-410-D-PRITSCHE-PLANE---1611303791723282975_big--21012210230488608200.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "Volkswagen",
      model: "Golf",
      price: 100000,
      year: 2018,
      origin: "private",
      fuel: "electric",
      available: true,
      thumbnailUrl:
          "https://www.carpixel.net/w/58008a357e25a5852004845489b41418/volkswagen-e-golf-5-door-car-wallpaper-65345.jpg"),
  Ads.card(
      idAds: Uuid(options: {'grng': UuidUtil.cryptoRNG}).v1(),
      make: "DAF",
      model: "XF",
      price: 250000,
      year: 2007,
      origin: "commercial",
      fuel: "diesel",
      available: true,
      thumbnailUrl:
          "https://images.tradus.com/v1/f52025f9-5ee9-4559-b3ef-12a31c4ab0c2.jpeg")
];
