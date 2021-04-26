import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:souqy/model/user_model.dart';

abstract class Database {}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid});
  final String uid;
  final _firestore = FirebaseFirestore.instance;

  Future<void> storeUserInfo(UserModel user) async {
    String path = "/user/${user.uid}";
    final firestore_ref = _firestore.doc(path);
    await firestore_ref.set(user.address);
  }
}
