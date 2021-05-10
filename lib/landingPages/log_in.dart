import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/souqy_submit_button.dart';
import 'package:souqy/service/firebase_auth_exceptions_handling.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

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

  bool _signInWithEmailAndPassword(String email, String password) {
    final status = locator
        .get<UserController>()
        .signInWithEmailAndPassword(email: email, password: password);
    if (status == AuthResultStatus.successful) {
      return true;
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      print(errorMsg);

      // _showAlertDialog(errorMsg);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool _isValid = false;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
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
                      SouqyFormField(
                        label: Strings.e_mail,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.required(Strings.e_mailInValid),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      SouqyFormField(
                        label: Strings.password,
                        controller: _passwordController,
                        validator: Validators.compose([
                          Validators.required(Strings.passwordInValidRequired),
                          Validators.minLength(
                              8, Strings.passwordInValidLength),
                        ]),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      SouqySubmitBotton(
                          label: Strings.login,
                          onPress: () {
                            if (_formKey.currentState.validate()) {
                              if (_signInWithEmailAndPassword(
                                  email, password)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      Strings.success(Strings.login),
                                    ),
                                  ),
                                );
                              }
                            }
                          }),
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
              Strings.visitor,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primeCOLOR,
              size: 30,
            ),
            // Image.asset(
            //   "images/leftarrow.png",
            //   height: 30,
            // )
          ],
        ),
      ),
    );
  }

  Text buildTitleText() {
    return Text(
      Strings.appName,
      style: TextStyle(
        color: primeCOLOR,
        fontSize: 73,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: borderColor,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    );
  }
}
