import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_page.dart';
import 'package:souqy/landingPages/log_in.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: locator.get<UserController>().authStateChanges(),
      builder: (context, snapshot) {
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return HomePage();
          }
        } else if (snapshot.hasError) {
          children = SouqyStyle.errorWidget(snapshot.error);
        } else {
          children = SouqyStyle.waitingWidget();
        }
        return Scaffold(
          appBar: souqyAppBar("normal", context),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          )),
        );
      },
    );
  }
}
