import 'package:flutter/material.dart';
import 'package:souqy/model/more_info_car.dart';
import 'package:souqy/trash/3.dart';
import 'package:souqy/widget/souqy_car_card.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class SouqyHomePage extends StatelessWidget {
  final bool shrinkWrap;
  SouqyHomePage({Key key, this.shrinkWrap = false}) : super(key: key);
  var uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final List<Map> myProducts =
    //     List.generate(11, (index) => {"id": index, "name": "Product $index"})
    //         .toList();
    // print(dataList.length);
    // for (var x in dataList) {
    //   print(
    //       'id : ${x.card.idAds} ,make :${x.card.make} , model : ${x.card.model} , price : ${x.card.price} , year ${x.card.year}, origin ${x.card.origin} , fuel ${x.card.fuel} , avail ${x.card.available}');
    // }

    final List<String> imgListTemp0 = [
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg__marking_background__sm_/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%2815%29.jpg',
      "https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%283%29.jpg",
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1001x565p.jpg',
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg__marking_background__sm_/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%2813%29.jpg',
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg__marking_background__sm_/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%289%29.jpg',
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg__marking_background__sm_/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%288%29.jpg',
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%281%29.jpg',
      'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%282%29.jpg',
      "https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg__marking_background__sm_/v1/editorial/2021-Mercedes-Benz-S-Class-S-450-sedan-red-press-image-1200x800p-%2811%29.jpg",
    ];

    dataList[0].moreInfo = MoreInfoCar(
      imageList: imgListTemp0,
      kilo: 2000,
      passengers: 5,
      color: "red",
      gear: "manual",
      engin: 3500,
      oldOwner: 0,
      feature: ["Sentral closure", "Magnesium rims", "Airbag protection"],
      additionalInformation: "this is add text hi im hear",
      publishDate: "2/5/2019",
      userId: dataList[0].card.idAds,
      paymentMethod: "installments",
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        alignment: Alignment.center,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (size.width * .00145),
            crossAxisSpacing: 4,
            mainAxisSpacing: 2,
          ),
          itemCount: dataList.length,
          shrinkWrap: true,
          // shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return SouqyCarCard(
              size: size,
              carAdsInfo: dataList[index],
            );
          },
        ),
      ),
    );
  }
}
