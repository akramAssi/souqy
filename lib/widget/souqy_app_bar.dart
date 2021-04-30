import 'package:flutter/material.dart';
import 'package:souqy/profile_pages/user_profile.dart';
import 'package:souqy/res/color.dart';

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

AppBar souqyAppBar(String type, BuildContext context) {
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
        actions.add(
          IconButton(
              padding: EdgeInsets.all(0),
              icon: Image.asset(
                "images/settings.png",
              ),
              onPressed: () {
                _openSetting(context);
              }),
        );
        break;
      }
    default:
      actions = null;
  }
  return AppBar(
    iconTheme: IconThemeData(color: primeCOLOR),
    backgroundColor: Colors.white,
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
      fontFamily: "Ayuthaya",
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
