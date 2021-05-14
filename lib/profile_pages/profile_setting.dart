import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/showExceptionDilog.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/souqy_app_bar.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'avatar.dart';

class ProfileSetting extends StatefulWidget {
  ProfileSetting({Key key}) : super(key: key);

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  UserModel currentUser = locator.get<UserController>().currentUser;
  PickedFile imageFile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String get name => _nameController.text;
  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get phone => _phoneController.text;
  String get city => _cityController.text;
  String get area => _areaController.text;
  List<String> cityList = ["nablus", "Qalqilya"];

  bool _saving = false;

  @override
  void initState() {
    setDefalut();
    super.initState();
  }

  Future<bool> saveInfo(
      {BuildContext context, String phone, String city, String area}) async {
    print("akram-dsdsd");
    await locator
        .get<UserController>()
        .storeAddress(phone: phone, city: city, area: area)
        .onError((error, stackTrace) async {
      showExceptionDialog(context,
          title: Strings.signOut, content: error.toString());
    });
    if (imageFile != null) {
      await locator
          .get<UserController>()
          .uploadProfilePicture(imageFile)
          .onError((error, stackTrace) {
        showExceptionDialog(context,
            title: Strings.upLoad, content: Strings.upLoadFailed);
      });
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void onPressYear(dynamic value) {
    print(value.toString());
    setState(() {
      _cityController.text = value?.toString() ?? cityList[0];
    });
    Navigator.of(context).pop();
    // _goNext(_modelFoucs);
  }

  @override
  Widget build(BuildContext context) {
    // showExeptionDilog(context,
    //     title: Text("download failure"), content: "sadasdasdas");
    //
    print(currentUser?.avatarUrl);
    currentUser = locator.get<UserController>().currentUser;
    // setDefalut();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: souqyAppBar("profileSettin", context),
      body: ModalProgressHUD(
          child: buildForm(context, _formKey),
          inAsyncCall: _saving,
          color: borderTextfieldColor,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primeCOLOR),
          )),
    );
  }

  SingleChildScrollView buildForm(
      BuildContext context, GlobalKey<FormState> _formKey) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(
                avatarUrl: currentUser?.avatarUrl,
                imageFile: imageFile,
                // avatarUrl:
                // "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=5324479827627077&height=50&width=50&ext=1621768726&hash=AeSBNiS0VjnWYrrmnJ0",
                onPress: () async {
                  imageFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);

                  setState(() {});

                  print(imageFile.path);
                },
                isSetting: true,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                child: Column(
                  children: [
                    SouqyFormField(
                      label: Strings.name,
                      controller: _nameController,
                      validator: Validators.required(Strings.nameRequired),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SouqyFormField(
                      label: Strings.e_mail,
                      controller: _emailController,
                      validator: Validators.compose([
                        Validators.required(Strings.emailRequired),
                        Validators.patternRegExp(
                            RegExp(
                                r"(?:[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"),
                            Strings.emailInValid),
                      ]),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // SouqyFormField(
                    //   label: "كلمة المرور",
                    //   controller: _passwordController,
                    // ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    SouqyFormField(
                      label: Strings.city,
                      controller: _cityController,
                      isReadOnly: true,
                      onTop: () {
                        showBotomSheatDialogWithOneColumn(
                          context: context,
                          list: cityList,
                          onPress: onPressYear,
                        );
                      },
                      validator: Validators.required(Strings.cityRequired),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SouqyFormField(
                      label: Strings.area,
                      controller: _areaController,
                      validator: Validators.required(Strings.areaRequired),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: primeCOLOR,
                              onPrimary: backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: alertColor,
                              onPrimary: backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 22)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _saving = true;
                              });
                              bool upload = await saveInfo(
                                  phone: phone, area: area, city: city);
                              // bool upload = await demo();
                              if (upload == true) {}
                              setState(() {
                                _saving = false;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setDefalut() {
    currentUser = locator.get<UserController>().currentUser;
    // locator.get<UserController>().readAddres();
    _nameController.text = currentUser?.displayName ?? "";
    _emailController.text = currentUser?.email ?? "";
    _phoneController.text = currentUser?.phone ?? "";
    _cityController.text = currentUser?.city ?? "";
    _areaController.text = currentUser?.area ?? "";
  }

  Future<String> delay(int s, int index) {
    return Future.delayed(Duration(seconds: s), () => "done $index");
  }

  Future<bool> demo() async {
    await delay(2, 1);
    await delay(1, 2);
    return true;
  }
}
