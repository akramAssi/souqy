import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String uid;
  String email;
  String displayName;
  String avatarUrl;

  UserModel(this.uid, {this.displayName, this.email, this.avatarUrl});
  UserModel.user(User user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.email = user.email;
    if (user.photoURL != null) {
      this.avatarUrl = user.photoURL;
    }
  }
}
