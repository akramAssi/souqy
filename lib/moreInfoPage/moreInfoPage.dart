import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_available_label.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/model/card_info.dart';
import 'package:souqy/moreInfoPage/row_main_info.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class MoreInfoPage extends StatelessWidget {
  // final String label;
  final Ads carAdsInfo;

  MoreInfoPage({Key key, @required this.carAdsInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: souqyAppBar("normal", context),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Stack(
              children: [
                SouqyImageSlider(
                  imageList: carAdsInfo.moreInfo.imageList,
                  source: "Network",
                ),
                Positioned(
                    left: 33,
                    // right: size.width / 80,
                    top: 25.0,
                    child: SouqyAvailabellabel(
                        availabel: true, size: size, isCard: false))
              ],
            ),
            RowMainInfo(
              size: size,
              make: carAdsInfo.card.make,
              model: carAdsInfo.card.model,
              price: carAdsInfo.card.price,
            ),
            SizedBox(
              height: 25,
            ),
            Wrap(
              spacing: 50,
              runSpacing: 25,
              alignment: WrapAlignment.center,
              children: [
                Circleinfocard(
                    icon: "mini_car.png", label: carAdsInfo.card.origin),
                Circleinfocard(
                  icon: "kilo.png",
                  label: "${carAdsInfo.moreInfo.kilo}",
                ),
                Circleinfocard(
                  icon: "year.png",
                  label: "${carAdsInfo.card.year}",
                ),
                Circleinfocard(
                  icon: "car_seat.png",
                  label: "${carAdsInfo.moreInfo.passengers} seater",
                ),
                Circleinfocard(
                  icon: "color.png",
                  label: "${carAdsInfo.moreInfo.color}",
                ),
                Circleinfocard(
                  icon: "gear.png",
                  label: "${carAdsInfo.moreInfo.gear}",
                ),
                Circleinfocard(
                  icon: "engine.png",
                  label: "${carAdsInfo.moreInfo.engin}",
                ),
                Circleinfocard(
                    icon: "gas_station.png", label: carAdsInfo.card.fuel),
                Circleinfocard(
                  icon: "user.png",
                  label: "${carAdsInfo.moreInfo.oldOwner}",
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(
                  top: 13,
                  right: 10,
                  left: 10,
                ),
                child: Text(
                  Strings.carFeatures,
                  style: TextStyle(
                    color: primeCOLOR,
                    fontSize: 25,
                  ),
                )),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                  border: Border.all(color: primeCOLOR),
                  borderRadius: SouqyStyle.souqyBorderRadius),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (var feature in carAdsInfo.moreInfo.feature)
                    buildItemList(feature)

                  // buildItemList("راعش"),
                  // buildItemList("نظام صوتي"),
                  // buildItemList("جنط مغنيسيوم"),
                  // buildItemList("ايش ما بدك ضيف"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 13,
                right: 10,
                left: 10,
              ),
              child: Text(
                Strings.additionalInformation,
                style: TextStyle(
                  color: primeCOLOR,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: primeCOLOR),
                  borderRadius: SouqyStyle.souqyBorderRadius),
              child: Text("${carAdsInfo.moreInfo.additionalInformation}",
                  style: TextStyle(fontSize: 20, color: primeCOLOR)),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: primeCOLOR),
                  borderRadius: SouqyStyle.souqyBorderRadius),
              child: Column(
                children: [
                  buildRowInfo("images/user.png", "ناصر شنطي"),
                  buildRowInfo("images/phone.png", "0568555917"),
                  buildRowInfo(
                      "images/location.png", "قلقية-شارع ما بعرف وين انا "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("images/whatsapp.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset("images/email.png"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildRowInfo(String path, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Image.asset(
            path,
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(text, style: TextStyle(fontSize: 16, color: primeCOLOR))
        ],
      ),
    );
  }

  Row buildItemList(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PointList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Text(
            text,
            style: TextStyle(color: primeCOLOR, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class PointList extends StatelessWidget {
  const PointList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      alignment: Alignment.center,
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        border: Border.all(color: primeCOLOR),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primeCOLOR,
        ),
      ),
    );
  }
}

class Circleinfocard extends StatelessWidget {
  Circleinfocard({
    Key key,
    @required this.icon,
    @required this.label,
  }) : super(key: key);
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: borderTextfieldColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/$icon",
            width: 28,
            height: 28,
            color: fontColor,
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: AutoSizeText(
              label,
              maxLines: 1,
              minFontSize: 5,
              style: TextStyle(
                fontSize: 12,
                color: alertColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
