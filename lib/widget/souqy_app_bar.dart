import 'package:flutter/material.dart';
import 'package:souqy/add_page/add_page.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/profile_pages/user_profile.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/trash/1.dart';
import 'package:souqy/view_controller/ads_controller.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/showExceptionDilog.dart';

import '../profile_pages/profile_setting.dart';

void _openProfile(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => UserProfile(),
      fullscreenDialog: true,
    ),
  );
}

void _openSetting(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => ProfileSetting(),
      fullscreenDialog: true,
    ),
  );
}

Future<void> _singOut(BuildContext context) async {
  await locator
      .get<UserController>()
      .signOut()
      .then((value) => Navigator.of(context).pop())
      .onError((error, stackTrace) {
    showExceptionDialog(context,
        title: Strings.signOut, content: error.toString());
  });
  // showMyDialog(context);
}

AppBar souqyAppBar(
  String type,
  BuildContext context, {
  VoidCallback soldOnPress,
  VoidCallback editOnPress,
  Ads ads,
}) {
  List<Widget> actions = [];
  switch (type) {
    case "profile":
      {
        actions.add(
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "images/man.png",
            ),
            onPressed: () => _openProfile(context),
          ),
        );
        break;
      }
    case "settings":
      {
        actions.addAll([
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.logout),
            onPressed: () => _singOut(context),
          ),
          IconButton(
              padding: EdgeInsets.all(0),
              icon: Image.asset(
                "images/settings.png",
              ),
              onPressed: () {
                _openSetting(context);
              }),
        ]);
        break;
      }
    case "owner":
      {
        actions.addAll(
          [
            IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.edit,
                color: primeCOLOR,
              ),
              onPressed: editOnPress,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                child: Text(
                  Strings.sold,
                  style: TextStyle(color: alertColor),
                ),
                onPressed: soldOnPress,
              ),
            ),
          ],
        );
        break;
      }

    case "notOwner":
      {
        actions.add(
          IconButton(
              splashColor: primeCOLOR,
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.bookmark_border,
                color: primeCOLOR,
              ),
              onPressed: soldOnPress),
        );
        break;
      }
    case "notOwnerBookmark":
      {
        actions.add(
          IconButton(
              splashColor: primeCOLOR,
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.bookmark,
                color: primeCOLOR,
              ),
              onPressed: soldOnPress),
        );
        break;
      }
    default:
      actions = null;
  }
  return AppBar(
    iconTheme: IconThemeData(color: primeCOLOR),
    backgroundColor: backgroundColor,
    elevation: .7,
    title: buildTitleText(),
    centerTitle: true,
    actions: actions,
  );
}

Text buildTitleText() {
  return Text(
    "SOUQY",
    style: TextStyle(
      color: primeCOLOR,
      fontSize: 25,
      shadows: [
        Shadow(
          blurRadius: 1.2,
          color: Color(0xff958585),
          offset: Offset(0.8, 0.8),
        ),
      ],
    ),
  );
}
