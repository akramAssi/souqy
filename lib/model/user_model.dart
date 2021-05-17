import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  String uid;
  String displayName;
  String email;
  String avatarUrl;
  String phone;
  String city;
  String area;

  UserModel(this.uid,
      {this.displayName,
      this.email,
      this.avatarUrl,
      this.area,
      this.city,
      this.phone});
  UserModel.user(User user) {
    this.uid = user.uid;
    // this.displayName = user.displayName;
    this.email = user.email;
    // if (user.photoURL != null) {
    //   this.avatarUrl = user.photoURL;
    // }
  }
  void setData(
      {@required String name,
      @required String email,
      @required String phone,
      @required String city,
      @required String area}) {
    this.displayName = name;
    this.email = email;
    this.phone = phone;
    this.area = area;
    this.city = city;
  }

  Map<String, dynamic> get address {
    return {
      "name": displayName,
      "email": email,
      "phone": phone,
      "city": city,
      "area": area,
    };
  }
}
