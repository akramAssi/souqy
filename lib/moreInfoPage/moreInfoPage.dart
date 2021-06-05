import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/add_page/add_page.dart';
import 'package:souqy/home_pages/souqy_available_label.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/moreInfoPage/row_main_info.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/view_controller/ads_controller.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class MoreInfoPage extends StatefulWidget {
  // final String label;
  Ads carAdsInfo;

  MoreInfoPage({Key key, @required this.carAdsInfo}) : super(key: key);

  @override
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  Ads currentAds;
  UserModel currentUser = locator.get<UserController>().currentUser;
  // Future<UserModel> ownerAds;
  @override
  void initState() {
    super.initState();
    currentAds = widget.carAdsInfo;
  }

  Future<void> onPress() async {
    await locator
        .get<AdsController>()
        .soldAds(currentAds.id)
        .then((value) => setState(() {
              currentAds.avaliable = false;
            }));
  }

  Future<void> _openEditPage(BuildContext context, Ads ads) async {
    Ads res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: souqyAppBar("normal", "SOUQY", context),
            body: AddPage(
              carAds: currentAds,
            )),
        fullscreenDialog: true,
      ),
    );
    if (res != null) {
      setState(() {
        currentAds = res;
      });
    }
  }

  Future<void> onPressSaveBookmark() async {
    await locator
        .get<UserController>()
        .addBookmark(currentAds.id)
        .then((value) {
      currentUser = locator.get<UserController>().currentUser;
      setState(() {});
    });
  }

  Future<void> onPressUnSaveBookmark() async {
    await locator
        .get<UserController>()
        .deleteBookmarkUser(currentAds.id)
        .then((value) {
      currentUser = locator.get<UserController>().currentUser;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> payment;
    if (currentAds.paymentMethod.contains(Strings.installment)) {
      payment = [
        Container(
            padding: EdgeInsets.only(
              top: 13,
              right: 10,
              left: 10,
            ),
            child: Text(
              Strings.installmentDetail,
              style: TextStyle(
                color: primeCOLOR,
                fontSize: 20,
              ),
            )),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
              border: Border.all(color: primeCOLOR),
              borderRadius: SouqyStyle.souqyBorderRadius),
          child: Column(
            children: [
              Row(
                children: [
                  Text(Strings.downPayment + " :",
                      style: TextStyle(fontSize: 18, color: primeCOLOR)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("${currentAds.downPayment}",
                      style: TextStyle(fontSize: 18, color: primeCOLOR)),
                  // Text("${carAdsInfo.moreInfo.downPayment}")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(Strings.monthlyPayment + " :",
                      style: TextStyle(fontSize: 16, color: primeCOLOR)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("${currentAds.monthlyPayment}",
                      style: TextStyle(fontSize: 16, color: primeCOLOR)),
                  // Text("${carAdsInfo.moreInfo.monthlyPayment}")
                ],
              ),
            ],
          ),
        )
      ];
    } else {
      payment = [SizedBox()];
    }
    Widget appBar;
    if (locator.get<UserController>().isAnonymous() == false) {
      if (currentAds.userId == locator.get<UserController>().currentUser.uid) {
        if (currentAds.avaliable == true) {
          appBar = souqyAppBar("owner", "SOUQY", context, soldOnPress: onPress,
              editOnPress: () {
            _openEditPage(context, currentAds);
          }, ads: currentAds);
        } else {
          appBar = souqyAppBar("normal", "SOUQY", context);
        }
      } else if (currentUser.bookmark.contains(currentAds.id)) {
        appBar = souqyAppBar("notOwnerBookmark", "SOUQY", context,
            soldOnPress: onPressUnSaveBookmark);
      } else {
        appBar = souqyAppBar(
          "notOwner",
          "SOUQY",
          context,
          soldOnPress: onPressSaveBookmark,
        );
      }
    } else if (locator.get<UserController>().isAnonymous()) {
      appBar = souqyAppBar("Login", "SOUQY", context);
    } else if (currentUser.bookmark != null &&
        currentUser.bookmark.contains(currentAds.id)) {
      appBar = souqyAppBar("notOwnerBookmark", "SOUQY", context,
          soldOnPress: onPressUnSaveBookmark);
    } else {
      appBar = souqyAppBar(
        "BookMark",
        "SOUQY",
        context,
      );
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder<UserModel>(
        future: locator.get<UserController>().readUserInfo(widget
            .carAdsInfo.userId), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            final UserModel owner = snapshot.data;
            var widgetList = [
              Stack(
                children: [
                  SouqyImageSlider(
                    imageList: currentAds.listImage,
                    source: "Network",
                  ),
                  Positioned(
                      left: 33,
                      // right: size.width / 80,
                      top: 25.0,
                      child: SouqyAvailabellabel(
                          availabel: currentAds.avaliable,
                          size: size,
                          isCard: false))
                ],
              ),
              RowMainInfo(
                size: size,
                make: currentAds.make,
                model: currentAds.model,
                price: currentAds.price,
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
                      icon: "mini_car.png", label: currentAds.origin),
                  Circleinfocard(
                    icon: "kilo.png",
                    label: "${currentAds.kilo}",
                  ),
                  Circleinfocard(
                    icon: "year.png",
                    label: "${currentAds.year}",
                  ),
                  Circleinfocard(
                    icon: "car_seat.png",
                    label: "${currentAds.passenger} seater",
                  ),
                  Circleinfocard(
                    icon: "color.png",
                    label: "${currentAds.color}",
                    isColord: true,
                  ),
                  Circleinfocard(
                    icon: "gear.png",
                    label: "${currentAds.gear}",
                  ),
                  Circleinfocard(
                    icon: "engine.png",
                    label: "${currentAds.engineSize}",
                  ),
                  Circleinfocard(
                      icon: "gas_station.png", label: currentAds.fuel),
                  Circleinfocard(
                    icon: "user.png",
                    label: "${currentAds.oldOwner}",
                  ),
                  Circleinfocard(
                    icon: "${currentAds.type}.png",
                    label: "${currentAds.type}",
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: payment,
              ),
            ];
            if (currentAds.carFeature != null &&
                currentAds.carFeature.isNotEmpty) {
              widgetList.addAll([
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
                        fontSize: 20,
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
                      for (var feature in currentAds.carFeature)
                        buildItemList(feature)
                    ],
                  ),
                ),
              ]);
            }
            if (currentAds.additionalInformation != null &&
                currentAds.additionalInformation.isNotEmpty) {
              widgetList.addAll([
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
                  child: Text("${currentAds.additionalInformation}",
                      style: TextStyle(fontSize: 20, color: primeCOLOR)),
                )
              ]);
            }

            widgetList.addAll([
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: primeCOLOR),
                    borderRadius: SouqyStyle.souqyBorderRadius),
                child: Column(
                  children: [
                    buildRowInfo("images/user.png", owner.displayName),
                    buildRowInfo("images/phone.png", owner.phone),
                    buildRowInfo(
                        "images/location.png", "${owner.city} - ${owner.area}"),
                    buildRowInfo("images/calendar.png",
                        currentAds.publishDate.toString()),
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
            ]);

            return Container(
              color: Colors.white,
              child: ListView(
                children: widgetList,
              ),
            );
          } else if (snapshot.hasError) {
            children = SouqyStyle.errorWidget(snapshot.error);
          } else {
            children = SouqyStyle.waitingWidget();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
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
          Text(text ?? "", style: TextStyle(fontSize: 16, color: primeCOLOR))
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
  PointList({
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
    this.isColord = false,
  }) : super(key: key) {
    if (isColord) {
      String valueString =
          label.split('(0x')[1].split(')')[0]; // kind of hacky..
      int value = int.parse(valueString, radix: 16);
      _otherColor = new Color(value);
    } else {
      _otherColor = fontColor;
    }
  }
  final String icon;
  final String label;
  final bool isColord;
  Color _otherColor;

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
          Container(
            decoration:
                _otherColor == carColor[0] || _otherColor == Color(0xffefebe9)
                    ? BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 15,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      )
                    : null,
            child: Image.asset(
              "images/$icon",
              width: 28,
              height: 28,
              color: _otherColor,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: AutoSizeText(
              isColord ? nameColor[carColor.indexOf(_otherColor)] : label,
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
