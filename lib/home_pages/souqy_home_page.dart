import 'package:flutter/material.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/widget/souqy_car_card.dart';

class SouqyHomePage extends StatelessWidget {
  final bool shrinkWrap;
  final List<Ads> list;
  SouqyHomePage({Key key, this.shrinkWrap = false, this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (list == null || list.length <= 0) {
      return Column(
        children: [
          Center(
            child: Text(
              Strings.noDataMessage,
              style: TextStyle(fontSize: 30, color: primeCOLOR),
            ),
          ),
          SizedBox(
            height: 200,
          )
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        alignment: Alignment.center,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 3,
            childAspectRatio:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? (size.width * .00145)
                    : (size.height * .00149),
            crossAxisSpacing: 4,
            mainAxisSpacing: 2,
          ),
          itemCount: list.length,
          shrinkWrap: true,
          // shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return SouqyCarCard(
              size: size,
              carAdsInfo: list[index] ?? null,
            );
          },
        ),
      ),
    );
  }
}
