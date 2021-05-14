import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_available_label.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/model/card_info.dart';
import 'package:souqy/moreInfoPage/row_main_info.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class MoreInfoPage extends StatelessWidget {
  // final String label;
  final Ads carAdsInfo;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

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
                  imageList: imgList,
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
                  "الاضافات",
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
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
                "المعلومات الاضافية",
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Text("${carAdsInfo.moreInfo.additionalInformation}",
                  style: TextStyle(fontSize: 20, color: primeCOLOR)),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: primeCOLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
              child: Column(
                children: [
                  buildRowInfo("images/user.png", "ناصر شنطي"),
                  buildRowInfo("images/phone.png", "059798544"),
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
      width: 73,
      height: 73,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/$icon",
            width: 28,
            height: 28,
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
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
