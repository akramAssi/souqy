import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/widget/showExceptionDilog.dart';

abstract class Database {
  Future<void> storeUserInfo(UserModel user);
  void readUserInfo(UserModel user, String userId);
}

class FirestoreDatabase {
  // FirestoreDatabase({@required this.uid});
  // final String uid;
  final _firestore = FirebaseFirestore.instance;

  Future<void> storeUserInfo(UserModel user) async {
    final String path = "/user/${user.uid}";
    final firestoreRef = _firestore.doc(path);
    await firestoreRef.set(user.toJson());
  }

  Future<Map<String, dynamic>> readUserInfo(String userId) async {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    final String path = "/user/$userId";
    final firestoreRef = _firestore.doc(path);
    Map<String, dynamic> data;
    await firestoreRef.get().then((document) {
      data = document.data();
      if (data != null) {
        return data;
        // user.setData(
        //     name: data["name"],
        //     email: data["email"],
        //     phone: data["phone"] ?? "",
        //     city: data["city"] ?? "",
        //     area: data["area"] ?? "");
        // print(
        //     "firebase : ${data["phone"]} ,  ${data["city"]} , ${data["area"]}");
        // print("obj ${user.phone} ,  ${user.city} , ${user.area}");
      }
    });
    return data;
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

  Future<void> userInNablus() async {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    // final String path = "/user/${user.uid}";
    final firestoreRef =
        _firestore.collection("user").where("city", isEqualTo: "Qalqilya");
    // final snapshot = firestoreRef.snapshots();
    // snapshot.listen((event) {
    //   event.docs.forEach((element) {
    //     print(element.data());
    //   });
    // });
    print("hi  hi  hi");
    await firestoreRef.get().then((value) {
      value.docs.forEach((element) {
        print("-------------------------------------");
        print(element.id);
        print(element.data());
      });
    });
  }

  Future<void> createAds(data) async {
    // final String path = "/user/${user.uid}";
    var temp = {
      "cardInfo": {"id": "23232323"}
    };
    await _firestore.collection("ads").add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readAds() {
    final firestoreRef = _firestore.collection("ads");
    final snapshot = firestoreRef.snapshots();
    return snapshot;
    // snapshot.listen((event) {
    //   event.docs.forEach((element) {
    //     print(element.data());
    //   });
    // });
    /////////////////
    // List<Ads> x = [];
    // print("hi  hi  hi");
    // await firestoreRef.get().then((value) {
    //   value.docs.forEach((element) {
    //     print("-------------------------------------");
    //     print(element.id);
    //     print(element.data());
    //     x.add(Ads.fromJson(element.data()));
    //   });
    // });
    // return x;
  }
}
