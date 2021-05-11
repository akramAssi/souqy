import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/widget/showExceptionDilog.dart';

abstract class Database {
  Future<void> storeUserInfo(UserModel user);
  void readUserInfo(UserModel user);
}

class FirestoreDatabase implements Database {
  // FirestoreDatabase({@required this.uid});
  // final String uid;
  final _firestore = FirebaseFirestore.instance;

  Future<void> storeUserInfo(UserModel user) async {
    final String path = "/user/${user.uid}";
    final firestoreRef = _firestore.doc(path);
    await firestoreRef.set(user.address);
  }

  Future<void> readUserInfo(UserModel user) async {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    final String path = "/user/${user.uid}";
    final firestoreRef = _firestore.doc(path);
    await firestoreRef.get().then((document) {
      final data = document.data();
      if (data != null) {
        print(data);
        user.setAddress(
            phone: data["phone"] ?? "",
            city: data["city"] ?? "",
            area: data["area"] ?? "");

        print(
            "firebase : ${data["phone"]} ,  ${data["city"]} , ${data["area"]}");
        print("obj ${user.phone} ,  ${user.city} , ${user.area}");
      }
    });

    //   print(path);
    // } catch (e) {
    //   print("dsad");
    //   print(e);

    //   // showMyDialog(context);
    //   // showExeptionDilog(context,
    //   //     title: Text("download failure"), content: e.toString());
    // }

    // snapshot.map(
    //   (snapshot) {
    //     final data = snapshot.data();

    //   },
    // );
  }
}
