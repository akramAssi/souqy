import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/seller_pages/seller_profile.dart';

class SouqySellerList extends StatelessWidget {
  final String avatarUrl = null;
  void _openSellerProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SellerProfile(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          var textStyle = TextStyle(
            color: primeCOLOR,
            fontFamily: "Arial",
            fontSize: 20,
          );
          return InkWell(
            onTap: () {
              _openSellerProfile(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5, left: 5),
                    child: Column(
                      children: [
                        Text(
                          "معرض",
                          style: textStyle,
                        ),
                        Text(
                          "نابلس",
                          style: textStyle,
                        ),
                        Text(
                          "شارع",
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 3),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(),
                    ),
                    child: Stack(
                      children: [
                        avatarUrl == null
                            ? Image.asset(
                                "images/big_man.png",
                                height: 60,
                                width: 60,
                              )
                            : Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      avatarUrl,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
