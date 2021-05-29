import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class SellerProfile extends StatelessWidget {
  var damage = [0, 0, 0, 0, 0, 0];
  final String avatarUrl = null;
  var textStyle = TextStyle(
    color: primeCOLOR,
    fontFamily: "Arial",
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: souqyAppBar("none", "SOUQY", context),
      body: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  padding: EdgeInsets.all(7),
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
                Divider(
                  color: Color(0xff707070),
                  // height: 20,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "المضاف حديثا",
                        style: TextStyle(color: primeCOLOR),
                      ),
                      TextButton(
                          onPressed: null,
                          child: Text(
                            "عرض الكل",
                            style: TextStyle(color: primeCOLOR),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          SouqyHomePage(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
