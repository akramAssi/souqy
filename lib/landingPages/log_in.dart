import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_TextFiled.dart';
import 'package:souqy/widget/souqy_submit_button.dart';

import 'bottom_sing_in.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({
    Key key,
  }) : super(key: key);

  String get email => _emailController.text;
  String get password => _passwordController.text;

  void singInAnonmymous() {
    locator.get<UserController>().singInAnonmymous();
  }

  Future<void> _signInWithEmailAndPassword(String email, String password) =>
      locator
          .get<UserController>()
          .signInWithEmailAndPassword(email: email, password: password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundCOLOR,
      body: Center(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: buildTitleText(),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 40, left: 42, right: 42, bottom: 20),
                  child: Column(
                    children: [
                      SouqyTextField(
                        lable: "البريد الإلكتروني",
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      SouqyTextField(
                        lable: "كلمة المرور",
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      SouqySubmitBotton(
                        onPress: () =>
                            {_signInWithEmailAndPassword(email, password)},
                      ),
                    ],
                  ),
                ),
                BottomSingIn(
                  isLogin: true,
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildTextButton() {
    return TextButton(
      onPressed: singInAnonmymous,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "دخول كزائر",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              "images/leftarrow.png",
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Text buildTitleText() {
    return Text(
      "SOUQY",
      style: TextStyle(
        color: primeCOLOR,
        fontSize: 73,
        fontFamily: "Ayuthaya",
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Color(0xff958585),
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    );
  }
}
