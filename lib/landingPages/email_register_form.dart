import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/service/firebase_auth_exceptions_handling.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/showExceptionDilog.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/souqy_app_bar.dart';
import 'package:souqy/widget/souqy_submit_button.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'bottom_sing_in.dart';

class EmailRegisterForm extends StatefulWidget {
  EmailRegisterForm({Key key}) : super(key: key);

  @override
  _EmailRegisterFormState createState() => _EmailRegisterFormState();
}

class _EmailRegisterFormState extends State<EmailRegisterForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  String get name => _nameController.text;

  String get email => _emailController.text;

  String get password => _passwordController.text;

  String get phone => _phoneController.text;

  bool _saving = false;

  Future<void> _creatUserWithEmailAndPassword(
      BuildContext context, String name, String email, String password) async {
    await locator
        .get<UserController>()
        .creatUserWithEmailAndPassword(
            name: name, email: email, password: password, phone: phone)
        .then((value) {
      if (value == AuthResultStatus.successful) {
        locator.get<UserController>().refresh().onError((error, stackTrace) {
          showExceptionDialog(context,
              title: Strings.userFetchFailed, content: error.toString());
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Strings.success(Strings.login),
            ),
          ),
        );
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(value);
        showExceptionDialog(context, title: Strings.login, content: errorMsg);
      }
    });

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: souqyAppBar("setttings", "SOUQY", context),
      body: ModalProgressHUD(
          child: buildForm(_formKey, context),
          inAsyncCall: _saving,
          color: borderTextfieldColor,
          progressIndicator: SouqyStyle.souqyIndicator),
    );
  }

  Center buildForm(GlobalKey<FormState> _formKey, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 5, left: 42, right: 42, bottom: 15),
                child: Column(
                  children: [
                    SouqyFormField(
                      label: Strings.name,
                      controller: _nameController,
                      validator: Validators.required(Strings.nameRequired),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SouqyFormField(
                      label: Strings.e_mail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.compose([
                        Validators.required(Strings.emailRequired),
                        Validators.patternRegExp(
                            RegExp(
                                r"(?:[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"),
                            Strings.emailInValid),
                      ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SouqyFormField(
                      label: Strings.password,
                      controller: _passwordController,
                      obscureText: true,
                      validator: Validators.compose([
                        Validators.required(Strings.passwordInValidRequired),
                        Validators.minLength(8, Strings.passwordInValidLength),
                      ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SouqyFormField(
                      label: Strings.phone,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: Validators.compose([
                        Validators.required(Strings.phoneInValidRequired),
                        Validators.patternRegExp(RegExp(r"^[0-9]\d*(\.\d+)?$"),
                            Strings.phoneInValidNotString),
                        Validators.patternRegExp(RegExp(r"^05[0-9]+\d$"),
                            Strings.phoneInValidPrefix),
                        Validators.minLength(10, Strings.phoneInValidLength),
                        Validators.maxLength(10, Strings.phoneInValidLength),
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SouqySubmitBotton(
                      label: Strings.createAccount,
                      onPress: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _saving = true;
                          });
                          _creatUserWithEmailAndPassword(
                                  context, name, email, password)
                              .then((value) {
                            setState(() {
                              _saving = false;
                            });
                          });
                        }
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
    );
  }

  Text buildTitleText() {
    return Text(
      Strings.appName,
      style: TextStyle(
        color: primeCOLOR,
        fontSize: 25,
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
