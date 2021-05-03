import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/widget/showExceptionDilog.dart';

abstract class Database {
  Future<void> storeUserInfo(BuildContext context, UserModel user);
  void readUserInfo(BuildContext context, UserModel user);
}

class FirestoreDatabase implements Database {
  // FirestoreDatabase({@required this.uid});
  // final String uid;
  final _firestore = FirebaseFirestore.instance;

  Future<void> storeUserInfo(BuildContext context, UserModel user) async {
    try {
      final String path = "/user/${user.uid}";
      final firestoreRef = _firestore.doc(path);
      await firestoreRef.set(user.address);
    } catch (e) {
      showExceptionDialog(context,
          title: Text("Storage failure"), content: e.toString());

      print(e);
    }
  }

  void readUserInfo(BuildContext context, UserModel user) {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    final String path = "/user/${user.uid}";
    final firestoreRef = _firestore.doc(path);
    firestoreRef.get().then((document) {
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

    print(path);
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
