import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_Info_Circle_Card.dart';
import 'package:souqy/home_pages/souqy_available_lable.dart';
import 'package:souqy/home_pages/souqy_info_card.dart';
import 'package:souqy/home_pages/souqy_thumbnail_card.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/profile_pages/avatar.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class UserProfile extends StatelessWidget {
  var damage = [0, 0, 0, 0, 0, 0];

  UserModel currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundCOLOR,
      appBar: souqyAppBar("settings", context),
      body: ListView(
        children: [
          Center(
            child: Avatar(
              onPress: null,
              isSetting: false,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                alignment: Alignment.center,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (size.width * .0016),
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: 13,
                  shrinkWrap: true,
                  // shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return SouqyCarCard(
                      size: size,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

int index = 0;

class SouqyCarCard extends StatelessWidget {
  // final int index;

  const SouqyCarCard({
    Key key,
    @required this.size,
    // this.index,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Player ${index + 1}');
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
              SouqyAvailableLable(
                size: size,
                available: true,
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
