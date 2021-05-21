import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/profile_pages/avatar.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/ads_controller.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class UserProfile extends StatelessWidget {
  void _openPage(BuildContext context, Widget openWidget) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => openWidget,
        fullscreenDialog: true,
      ),
    );
  }

  UserModel currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: souqyAppBar("settings", context),
      body: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          direction: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: Avatar(
                    avatarUrl: currentUser?.avatarUrl,
                    onPress: null,
                    isSetting: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    currentUser?.displayName ?? "",
                    style: TextStyle(color: fontColor, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            // SouqyHomePage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: buildContainer(
                      Strings.myAds,
                      Image.asset(
                        "images/myAds.png",
                        color: primeCOLOR,
                        width: 70,
                        height: 70,
                      ), () {
                    _openPage(
                      context,
                      Scaffold(
                        appBar: souqyAppBar("normal", context),
                        body: ListView(
                          children: [
                            StreamBuilder(
                              stream: locator
                                  .get<AdsController>()
                                  .getUserAds(currentUser.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  QuerySnapshot<Map<String, dynamic>> map =
                                      snapshot.data;
                                  List<Ads> list = [];
                                  map.docs.forEach((doc) {
                                    Ads temp = Ads.fromJson(doc.data());
                                    temp.id = doc.id;
                                    list.add(temp);
                                  });
                                  return SouqyHomePage(
                                    shrinkWrap: false,
                                    list: list,
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Flexible(
                  flex: 1,
                  child: buildContainer(
                      Strings.bookmark,
                      Icon(
                        Icons.bookmarks_outlined,
                        color: primeCOLOR,
                        size: 70,
                      ), () {
                    _openPage(
                      context,
                      buildBookmarkPage(context),
                    );
                  }),
                ),
              ],
            ),
            //
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildBookmarkPage(BuildContext context) {
    return Scaffold(
      appBar: souqyAppBar("normal", context),
      body: ListView(
        children: [
          FutureBuilder<List<Ads>>(
            future: locator.get<UserController>().getUserBookmark(),
            builder: (BuildContext context, AsyncSnapshot<List<Ads>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                return SouqyHomePage(
                  shrinkWrap: false,
                  list: snapshot.data,
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
          )
        ],
      ),
    );
  }

  InkWell buildContainer(String label, Widget image, VoidCallback onTap) {
    return InkWell(
      splashColor: borderCard,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: borderColor,
          border: Border.all(color: borderTextfieldColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          // boxShadow: [
          //   BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            SizedBox(
              height: 20,
            ),
            Text(
              label,
              style: TextStyle(color: primeCOLOR, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
