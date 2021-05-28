import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/showExceptionDilog.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/souqy_submit_button.dart';
import 'package:souqy/service/firebase_auth_exceptions_handling.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'bottom_sing_in.dart';

class LoginPage extends StatefulWidget {
  final bool isDialog;
  LoginPage({
    Key key,
    this.isDialog,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _saving = false;

  String get email => _emailController.text;

  String get password => _passwordController.text;

  void singInAnonmymous() {
    locator
        .get<UserController>()
        .singInAnonmymous()
        .onError((error, stackTrace) {
      showExceptionDialog(context,
          title: Strings.signInAnonmymous, content: error.toString());
    });
  }

  Future<void> _signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    locator
        .get<UserController>()
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (value == AuthResultStatus.successful) {
<<<<<<< Updated upstream
=======
        if (widget.isDialog) {
          Navigator.of(context).pop();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Strings.success(Strings.login),
            ),
          ),
        );
>>>>>>> Stashed changes
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(value);
        showExceptionDialog(context, title: Strings.login, content: errorMsg);
        print(errorMsg);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: backgroundColor,
      // body: _buildForm(_formKey, context),
      body: ModalProgressHUD(
        child: _buildForm(_formKey, context),
        inAsyncCall: _saving,
        progressIndicator: SouqyStyle.souqyIndicator,
      ),
    );
  }

  Form _buildForm(GlobalKey<FormState> _formKey, BuildContext context) {
    return Form(
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
                      validator: Validators.compose([
                        Validators.required(Strings.emailRequired),
                        Validators.patternRegExp(
                            RegExp(
                                r"(?:[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"),
                            Strings.emailInValid),
                      ]),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    SouqyFormField(
                      label: Strings.password,
                      obscureText: true,
                      controller: _passwordController,
                      validator: Validators.compose([
                        Validators.required(Strings.passwordInValidRequired),
                        Validators.minLength(8, Strings.passwordInValidLength),
                      ]),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    SouqySubmitBotton(
                        label: Strings.login,
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _saving = true;
                            });
                            _signInWithEmailAndPassword(
                                    context, email, password)
                                .then((value) {
                              setState(() {
                                _saving = false;
                              });
                            });
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
    );
  }

  Widget buildTextButton() {
    if (locator.get<UserController>().currentUser != null) {
      return SizedBox();
    } else {
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
