import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
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
    return Scaffold(
      backgroundColor: backgroundColor,
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
          SouqyHomepage(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
