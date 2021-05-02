import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_available_lable.dart';
import 'package:souqy/moreInfoPage/row_main_info.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class MoreInfoPage extends StatelessWidget {
  String lable;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: souqyAppBar("normal", context),
      body: Container(
        color: Colors.white,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              Stack(
                children: [
                  CarouselWithIndicatorDemo(),
                  Positioned(
                      left: 33,
                      // right: size.width / 80,
                      top: 25.0,
                      child: SouqyAvailableLable(
                          available: true, size: size, isCard: false))
                ],
              ),
              RowMainInfo(
                size: size,
                make: "فولكسفاغن",
                model: "كرافتر",
                price: "100000",
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
                    icon: "mini_car.png",
                    lable: "خصوصي",
                  ),
                  Circleinfocard(
                    icon: "kilo.png",
                    lable: "100",
                  ),
                  Circleinfocard(
                    icon: "year.png",
                    lable: "2012",
                  ),
                  Circleinfocard(
                    icon: "car_seat.png",
                    lable: "5 مقاعد",
                  ),
                  Circleinfocard(
                    icon: "color.png",
                    lable: "اخضر",
                  ),
                  Circleinfocard(
                    icon: "gear.png",
                    lable: "عادي",
                  ),
                  Circleinfocard(
                    icon: "engine.png",
                    lable: "1800",
                  ),
                  Circleinfocard(icon: "gas_station.png", lable: "بنزين"),
                  Circleinfocard(
                    icon: "user.png",
                    lable: "بد ٢",
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
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: primeCOLOR),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildItemList("فتحة سقف"),
                    buildItemList("راعش"),
                    buildItemList("نظام صوتي"),
                    buildItemList("جنط مغنيسيوم"),
                    buildItemList("ايش ما بدك ضيف"),
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: primeCOLOR),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                child: Text(
                    "فخامه جميع الاضافات  ترخيص 1 ، مُكيّف إغلاق مركزي، فرش جلد",
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
            style: TextStyle(color: primeCOLOR, fontSize: 20),
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
    @required this.lable,
  }) : super(key: key);
  final String icon;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: BorderColor,
          )),
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
          Text(
            lable,
            style: TextStyle(
              fontSize: 12,
              color: redColor,
            ),
          ),
        ],
      ),
    );
  }
}
