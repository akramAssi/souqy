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

  Future<List<String>> readUserBookmark(String userId) async {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    final String path = "/user/$userId/save_post";
    final firestoreRef = _firestore.collection(path);
    List<String> tempList = [];
    await firestoreRef.get().then((document) {
      document.docs.forEach((doc) {
        if (doc != null || doc.data() != null) {
          tempList.add(doc.id);
        }
      });
      return tempList;
    });

    return tempList;
  }

  Future<String> readUrl() async {
    final String path = "/res/con";
    final firestoreRef = _firestore.doc(path);
    return await firestoreRef.get().then((document) {
      var data = document.data();

      return data["url"];
    });

    return "";
  }

  Future<void> deleteUserBookmark(String userId, String adsId) async {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    final String path = "/user/$userId/save_post/$adsId";
    await _firestore.doc(path).delete();
  }

  Future<List<Ads>> search() async {
    // try {
    // throw IntegerDivisionByZeroException;
    // print("dsadsad");
    // final String path = "/user/${user.uid}";
    final firestoreRef = _firestore
        .collection("ads")
        // .where("make", isEqualTo: make)
        .where("avaliable", isEqualTo: true)
        .orderBy("publishDate", descending: true);
    // .where("model", isEqualTo: "1-series")
    // .where("type", isEqualTo: "sedan")
    // .where("year", isEqualTo: 2005)
    // // .where("year", isLessThanOrEqualTo: 2010)
    // // .where("engineSize", isLessThanOrEqualTo: 4000)
    // // .where("engineSize", isGreaterThan: 2015)
    // .where("engineSize", isGreaterThanOrEqualTo: 30000)
    // .where("engineSize", isLessThanOrEqualTo: 200000);

    // final snapshot = firestoreRef.snapshots();
    // snapshot.listen((event) {
    //   event.docs.forEach((element) {
    //     print(element.data());
    //   });
    // });
    List<Ads> tempList = [];
    await firestoreRef.get().then((value) {
      value.docs.forEach((element) {
        Ads temp = Ads.fromJson(element.data());
        temp.id = element.id;
        tempList.add(temp);
      });
    });
    return tempList;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserAds(String id) {
    final firestoreRef =
        _firestore.collection("ads").where("userId", isEqualTo: id);
    // .orderBy("publishDate", descending: true);
    final snapshot = firestoreRef.snapshots();
    return snapshot;
  }

  Future<void> createAds(data, {String id}) async {
    if (id != null) {
      _firestore.collection("ads").doc(id).update(data);
    } else {
      await _firestore.collection("ads").add(data);
    }
  }

  Future<void> addBookmark(String data, String userid) async {
    await _firestore
        .collection("user")
        .doc(userid)
        .collection("save_post")
        .doc(data)
        .set({"post_id": data});
  }

  Future<void> solidAds(String id) async {
    // final String path = "/user/${user.uid}";
    await _firestore.collection("ads").doc(id).update({"avaliable": false});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readAds() {
    final firestoreRef = _firestore
        .collection("ads")
        .where("avaliable", isEqualTo: true)
        .orderBy("publishDate", descending: true);
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

  Future<List<Ads>> readBookmark(List<String> bookmark) async {
    // final String path = "/user/$userId/save_post";
    // final firestoreRef = _firestore.collection(path);
    // final snapshot = firestoreRef.snapshots();
    List<Ads> tempList = [];
    // await firestoreRef.get().then((document) {
    //   document.docs.forEach((doc) async {
    //     if (doc != null || doc.data() != null) {
    //       // tempList.add(doc.id);
    //       rint("data1 ----- $tempList");
    //       });
    //     }
    //   });
    //   print("data ----- $tempList");
    // })

    for (var element in bookmark) {
      await _firestore.collection("ads").doc(element).get().then((value) {
        Ads temp = Ads.fromJson(value.data());
        temp.id = element;
        tempList.add(temp);
      });
    }
    return tempList;
    // return snapshot;
  }
}
