import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  String uid;
  String displayName;
  String email;
  String avatarUrl;
  int phone;
  String city;
  String area;

  UserModel(this.uid, {this.displayName, this.email, this.avatarUrl});
  UserModel.user(User user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.email = user.email;
    if (user.photoURL != null) {
      this.avatarUrl = user.photoURL;
    }
  }
  void setAddress(
      {@required int phone, @required String city, @required String area}) {
    this.phone = phone;
    this.area = area;
    this.city = city;
  }

  Map<String, dynamic> get address {
    return {
      "phone": phone,
      "city": city,
      "area": area,
    };
  }
}
