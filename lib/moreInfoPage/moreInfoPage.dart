import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_available_label.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/moreInfoPage/row_main_info.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class MoreInfoPage extends StatefulWidget {
  // final String label;
  final Ads carAdsInfo;

  MoreInfoPage({Key key, @required this.carAdsInfo}) : super(key: key);

  @override
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  // Future<UserModel> ownerAds;
  @override
  void initState() {
    super.initState();
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> payment;
    if (widget.carAdsInfo.cardInfo.paymentMethod
        .contains(Strings.installment)) {
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
                  Text("5222",
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
                  Text("5222",
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: souqyAppBar("normal", context),
      body: FutureBuilder<UserModel>(
        future: locator.get<UserController>().readUserInfo(widget.carAdsInfo
            .moreInfo.userId), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            final UserModel owner = snapshot.data;
            return Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      SouqyImageSlider(
                        imageList: widget.carAdsInfo.moreInfo.listImage,
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
                    make: widget.carAdsInfo.cardInfo.make,
                    model: widget.carAdsInfo.cardInfo.model,
                    price: widget.carAdsInfo.cardInfo.price,
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
                          label: widget.carAdsInfo.cardInfo.origin),
                      Circleinfocard(
                        icon: "kilo.png",
                        label: "${widget.carAdsInfo.moreInfo.kilo}",
                      ),
                      Circleinfocard(
                        icon: "year.png",
                        label: "${widget.carAdsInfo.cardInfo.year}",
                      ),
                      Circleinfocard(
                        icon: "car_seat.png",
                        label: "${widget.carAdsInfo.moreInfo.passenger} seater",
                      ),
                      Circleinfocard(
                        icon: "color.png",
                        label: "${widget.carAdsInfo.moreInfo.color}",
                      ),
                      Circleinfocard(
                        icon: "gear.png",
                        label: "${widget.carAdsInfo.moreInfo.gear}",
                      ),
                      Circleinfocard(
                        icon: "engine.png",
                        label: "${widget.carAdsInfo.moreInfo.engineSize}",
                      ),
                      Circleinfocard(
                          icon: "gas_station.png",
                          label: widget.carAdsInfo.cardInfo.fuel),
                      Circleinfocard(
                        icon: "user.png",
                        label: "${widget.carAdsInfo.moreInfo.oldOwner}",
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: payment,
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
                        for (var feature
                            in widget.carAdsInfo.moreInfo.carFeature)
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
                    child: Text(
                        "${widget.carAdsInfo.moreInfo.additionalInformation}",
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
                        buildRowInfo("images/user.png", owner.displayName),
                        buildRowInfo("images/phone.png", owner.phone),
                        buildRowInfo("images/location.png",
                            "${owner.city} - ${owner.area}"),
                        buildRowInfo("images/calendar.png",
                            widget.carAdsInfo.moreInfo.publishDate.toString()),
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
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
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

//  future: ownerAds,
//         builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             print("alkobject");
//             print(snapshot.data.toJson());
//             final UserModel owner = snapshot.data;
//             return Container(
//               color: Colors.white,
//               child: ListView(
//                 children: [
//                   Stack(
//                     children: [
//                       SouqyImageSlider(
//                         imageList: widget.carAdsInfo.moreInfo.listImage,
//                         source: "Network",
//                       ),
//                       Positioned(
//                           left: 33,
//                           // right: size.width / 80,
//                           top: 25.0,
//                           child: SouqyAvailabellabel(
//                               availabel: true, size: size, isCard: false))
//                     ],
//                   ),
//                   RowMainInfo(
//                     size: size,
//                     make: widget.carAdsInfo.cardInfo.make,
//                     model: widget.carAdsInfo.cardInfo.model,
//                     price: widget.carAdsInfo.cardInfo.price,
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Wrap(
//                     spacing: 50,
//                     runSpacing: 25,
//                     alignment: WrapAlignment.center,
//                     children: [
//                       Circleinfocard(
//                           icon: "mini_car.png",
//                           label: widget.carAdsInfo.cardInfo.origin),
//                       Circleinfocard(
//                         icon: "kilo.png",
//                         label: "${widget.carAdsInfo.moreInfo.kilo}",
//                       ),
//                       Circleinfocard(
//                         icon: "year.png",
//                         label: "${widget.carAdsInfo.cardInfo.year}",
//                       ),
//                       Circleinfocard(
//                         icon: "car_seat.png",
//                         label: "${widget.carAdsInfo.moreInfo.passenger} seater",
//                       ),
//                       Circleinfocard(
//                         icon: "color.png",
//                         label: "${widget.carAdsInfo.moreInfo.color}",
//                       ),
//                       Circleinfocard(
//                         icon: "gear.png",
//                         label: "${widget.carAdsInfo.moreInfo.gear}",
//                       ),
//                       Circleinfocard(
//                         icon: "engine.png",
//                         label: "${widget.carAdsInfo.moreInfo.engineSize}",
//                       ),
//                       Circleinfocard(
//                           icon: "gas_station.png",
//                           label: widget.carAdsInfo.cardInfo.fuel),
//                       Circleinfocard(
//                         icon: "user.png",
//                         label: "${widget.carAdsInfo.moreInfo.oldOwner}",
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: payment,
//                   ),
//                   Container(
//                       padding: EdgeInsets.only(
//                         top: 13,
//                         right: 10,
//                         left: 10,
//                       ),
//                       child: Text(
//                         Strings.carFeatures,
//                         style: TextStyle(
//                           color: primeCOLOR,
//                           fontSize: 20,
//                         ),
//                       )),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     padding: EdgeInsets.all(13),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: primeCOLOR),
//                         borderRadius: SouqyStyle.souqyBorderRadius),
//                     child: Wrap(
//                       alignment: WrapAlignment.start,
//                       children: [
//                         for (var feature
//                             in widget.carAdsInfo.moreInfo.carFeature)
//                           buildItemList(feature)

//                         // buildItemList("راعش"),
//                         // buildItemList("نظام صوتي"),
//                         // buildItemList("جنط مغنيسيوم"),
//                         // buildItemList("ايش ما بدك ضيف"),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(
//                       top: 13,
//                       right: 10,
//                       left: 10,
//                     ),
//                     child: Text(
//                       Strings.additionalInformation,
//                       style: TextStyle(
//                         color: primeCOLOR,
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: primeCOLOR),
//                         borderRadius: SouqyStyle.souqyBorderRadius),
//                     child: Text(
//                         "${widget.carAdsInfo.moreInfo.additionalInformation}",
//                         style: TextStyle(fontSize: 20, color: primeCOLOR)),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: primeCOLOR),
//                         borderRadius: SouqyStyle.souqyBorderRadius),
//                     child: Column(
//                       children: [
//                         buildRowInfo("images/user.png", owner.displayName),
//                         buildRowInfo("images/phone.png", owner.phone),
//                         buildRowInfo("images/location.png",
//                             "${owner.city} - ${owner.area}"),
//                         buildRowInfo("images/calendar.png",
//                             widget.carAdsInfo.moreInfo.publishDate.toString()),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Image.asset("images/whatsapp.png"),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Image.asset("images/email.png"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }
//         },
//       ),
