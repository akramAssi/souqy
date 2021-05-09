import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';

import 'email_register_form.dart';

class BottomSingIn extends StatelessWidget {
  final bool isLogin;

  const BottomSingIn({Key key, @required this.isLogin}) : super(key: key);

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EmailRegisterForm(),
        // fullscreenDialog: true,
      ),
    );
  }

  void _logInWithEmail(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _signInWithGoogle(BuildContext context) =>
      locator.get<UserController>().signInWithGoogle(context);

  Future<void> _signInWithFacebook() =>
      locator.get<UserController>().signInWithFacebook();

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      Text(
        Strings.orLoginWith,
        style: TextStyle(color: primeCOLOR, fontSize: 15, fontFamily: "Arial"),
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Image.asset("images/google.png"),
            onPressed: () {
              _signInWithGoogle(context);
            },
          ),
          IconButton(
            icon: Image.asset("images/facebook.png"),
            onPressed: _signInWithFacebook,
          ),
        ],
      ),
    ];
    if (isLogin) {
      body.addAll([
        SizedBox(
          height: 8,
        ),
        TextButton(
          child: Text(
            Strings.createNewAccount,
            style: TextStyle(
              color: primeCOLOR,
              fontSize: 15,
              fontFamily: "Arial",
            ),
          ),
          onPressed: () => _signInWithEmail(context),
        ),
      ]);
    } else {
      body.addAll([
        SizedBox(
          height: 8,
        ),
        TextButton(
          child: Text(
            Strings.alreadyHaveAccount,
            style: TextStyle(
              color: primeCOLOR,
              fontSize: 15,
              fontFamily: "Arial",
            ),
          ),
          onPressed: () => _logInWithEmail(context),
        ),
      ]);
    }
    return Column(
      children: body,
    );
  }
}
