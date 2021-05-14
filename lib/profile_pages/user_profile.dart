import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/profile_pages/avatar.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class UserProfile extends StatelessWidget {
  UserModel currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: souqyAppBar("settings", context),
      body: ListView(
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
            height: 10,
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
