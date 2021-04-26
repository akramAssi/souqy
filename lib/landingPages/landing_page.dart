import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqy/home_page.dart';
import 'package:souqy/landingPages/log_in.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: locator.get<UserController>().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return HomePage();
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
