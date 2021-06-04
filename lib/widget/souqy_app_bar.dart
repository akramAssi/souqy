import 'package:flutter/material.dart';
import 'package:souqy/landingPages/log_in.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/profile_pages/user_profile.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/showExceptionDilog.dart';

import '../profile_pages/profile_setting.dart';
import 'dialog/show_option_dialog.dart';

void _openProfile(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserProfile(),
      fullscreenDialog: true,
    ),
  );
}

void openLogIn(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => Scaffold(
        appBar: souqyAppBar('normal', "Login", context),
        body: LoginPage(
          isDialog: true,
        ),
      ),
      fullscreenDialog: true,
    ),
  );
}

void openSetting(BuildContext context) {
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
  String title,
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
    case "Login":
      {
        actions.add(
          IconButton(
            icon: Icon(
              Icons.login,
            ),
            onPressed: () => openLogIn(context),
          ),
        );
        break;
      }
    case "BookMark":
      {
        actions.add(
          IconButton(
              icon: Icon(
                Icons.bookmark_border_outlined,
              ),
              onPressed: () {
                showOptionDialog(context);
              }),
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
            onPressed: soldOnPress,
            // onPressed: () {
            //   _openSetting(context);
            // }
          ),
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
    elevation: 0,
    title: buildTitleText(title),
    centerTitle: true,
    actions: actions,
  );
}

Text buildTitleText(String title) {
  return Text(
    title,
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
