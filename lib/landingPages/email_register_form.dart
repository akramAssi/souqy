import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/souqy_TextFiled.dart';
import 'package:souqy/widget/souqy_app_bar.dart';
import 'package:souqy/widget/souqy_submit_button.dart';

import 'bottom_sing_in.dart';

class EmailRegisterForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  EmailRegisterForm({Key key}) : super(key: key);

  String get name => _nameController.text;
  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get phone => _phoneController.text;

  Future<void> _creatUserWithEmailAndPassword(
      BuildContext context, String name, String email, String password) async {
    await locator.get<UserController>().creatUserWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
        );
    await locator.get<UserController>().storeAddress(context, phone: phone);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundCOLOR,
      appBar: souqyAppBar("setttings", context),
      body: Center(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 42, right: 42, bottom: 15),
                  child: Column(
                    children: [
                      SouqyTextField(
                        lable: "الاسم",
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SouqyTextField(
                        lable: "البريد الإلكتروني",
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SouqyTextField(
                        lable: "كلمة المرور",
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SouqyTextField(
                        lable: "رقم الهاتف",
                        controller: _phoneController,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SouqySubmitBotton(
                        label: "انشاء حساب ",
                        onPress: () {
                          _creatUserWithEmailAndPassword(
                              context, name, email, password);
                        },
                      )
                    ],
                  ),
                ),
                BottomSingIn(
                  isLogin: false,
                )
              ],
            ),
          ),
        ),
      ),
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
            blurRadius: 10.0,
            color: Color(0xff958585),
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    );
  }
}
