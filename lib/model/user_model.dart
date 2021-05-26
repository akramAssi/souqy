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
  List<String> bookmark;

  UserModel(this.uid,
      {this.displayName,
      this.email,
      this.avatarUrl,
      this.area,
      this.city,
      this.phone});
  UserModel.user(User user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.email = user.email;
    // if (user.photoURL != null) {
    //   this.avatarUrl = user.photoURL;
    // }
  }
  factory UserModel.fromJson(String id, Map<String, dynamic> json,
      {UserModel currentUser}) {
    final x = UserModel(
      id,
      area: json["area"] ?? currentUser?.area,
      city: json["city"] ?? currentUser?.city,
      email: json["email"] ?? currentUser?.email,
      displayName: json["name"] ?? currentUser?.displayName,
      phone: json["phone"] ?? currentUser?.phone,
    );
    return x;
  }

  Map<String, dynamic> toJson() => {
        "area": area,
        "city": city,
        "email": email,
        "name": displayName,
        "phone": phone,
      };
}
