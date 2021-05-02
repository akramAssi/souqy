import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_Info_Circle_Card.dart';
import 'package:souqy/home_pages/souqy_available_lable.dart';
import 'package:souqy/home_pages/souqy_info_card.dart';
import 'package:souqy/home_pages/souqy_thumbnail_card.dart';
import 'package:souqy/moreInfoPage/moreInfoPage.dart';

int index = 0;

class SouqyCarCard extends StatelessWidget {
  // final int index;

  SouqyCarCard({
    Key key,
    @required this.size,
    // this.index,
  }) : super(key: key);

  final Size size;

  void _openMoreInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => MoreInfoPage(),
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
              SouqyThumbnailCard(path: 'images/kia-op.jpg'),
              Positioned(
                right: size.width / 80,
                top: 25.0,
                child: SouqyAvailableLable(
                  size: size,
                  available: true,
                  isCard: true,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
              child: Row(
                children: [
                  SouqyInfoCard(
                    make: "مرسيدس",
                    model: "c300",
                    price: 115000,
                    size: size,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SouqyInfoCircleCard(
                        value: "${2012}",
                        path: "images/year.png",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SouqyInfoCircleCard(
                        value: "private",
                        path: "images/mini_car.png",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SouqyInfoCircleCard(
                        value: "petrol",
                        path: "images/gas_station.png",
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
