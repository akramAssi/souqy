import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/showExceptionDilog.dart';
import 'package:souqy/widget/souqy_TextFiled.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

import 'avatar.dart';

class ProfileSetting extends StatefulWidget {
  ProfileSetting({Key key}) : super(key: key);

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  UserModel currentUser = locator.get<UserController>().currentUser;
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

  @override
  void initState() {
    setDefalut();
    super.initState();
  }

  Future<void> saveAddress(
      {BuildContext context, String phone, String city, String area}) async {
    await locator
        .get<UserController>()
        .storeAddress(context, phone: phone, city: city, area: area);
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

  @override
  Widget build(BuildContext context) {
    // showExeptionDilog(context,
    //     title: Text("download failure"), content: "sadasdasdas");
    //

    setDefalut();

    return Scaffold(
      backgroundColor: backgroundCOLOR,
      appBar: souqyAppBar("profileSettin", context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(
                  avatarUrl: currentUser?.avatarUrl,
                  // avatarUrl:
                  // "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=5324479827627077&height=50&width=50&ext=1621768726&hash=AeSBNiS0VjnWYrrmnJ0",
                  onPress: () async {
                    var file = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    await locator
                        .get<UserController>()
                        .uploadProfilePicture(file);
                    setState(() {});

                    print(file.path);
                  }),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                  child: Column(
                    children: [
                      SouqyTextField(
                        lable: "الاسم",
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SouqyTextField(
                        lable: "البريد الالكتروني",
                        controller: _emailController,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SouqyTextField(
                      //   lable: "كلمة المرور",
                      //   controller: _passwordController,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      SouqyTextField(
                        lable: "رقم الهاتف",
                        controller: _phoneController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SouqyTextField(
                        lable: "محافظة",
                        controller: _cityController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SouqyTextField(
                        lable: "مدينة",
                        controller: _areaController,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              saveAddress(phone: phone, area: area, city: city);
                            },
                            child: Text("حفظ"),
                          ),
                        ],
                      )
                    ],
                  ),
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
}
