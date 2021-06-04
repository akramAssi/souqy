import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_Info_Circle_Card.dart';
import 'package:souqy/home_pages/souqy_available_label.dart';
import 'package:souqy/home_pages/souqy_info_card.dart';
import 'package:souqy/home_pages/souqy_thumbnail_card.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/moreInfoPage/moreInfoPage.dart';

int index = 0;

class SouqyCarCard extends StatelessWidget {
  // final int index;

  SouqyCarCard({
    Key key,
    @required this.size,
    @required this.carAdsInfo,
    // this.index,
  }) : super(key: key);

  final Size size;
  final Ads carAdsInfo;

  void _openMoreInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => MoreInfoPage(
          carAdsInfo: carAdsInfo,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _openMoreInfo(context);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: <Widget>[
              // SouqyThumbnailCard(path: 'images/kia-op.jpg'),
              SouqyThumbnailCard(path: carAdsInfo.urlThumb),
              Positioned(
                left: size.width / 80,
                top: 25.0,
                child: SouqyAvailabellabel(
                  size: size,
                  availabel: carAdsInfo.avaliable,
                  isCard: true,
                ),
              ),
            ]),
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: SouqyInfoCard(
                      make: carAdsInfo.make,
                      model: carAdsInfo.model,
                      price: carAdsInfo.price,
                      paymentMethod: carAdsInfo?.paymentMethod ?? "",
                      size: size,
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SouqyInfoCircleCard(
                        value: "${carAdsInfo.year}",
                        path: "images/year.png",
                        size: size,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SouqyInfoCircleCard(
                        value: "${carAdsInfo.gear}",
                        path: "images/gear.png",
                        size: size,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SouqyInfoCircleCard(
                        value: "${carAdsInfo.fuel}",
                        path: "images/gas_station.png",
                        size: size,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
