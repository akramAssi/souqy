import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souqy/model/user_model.dart';

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

  void readUserInfo(UserModel user) {
    final String path = "/user/${user.uid}";
    final firestoreRef = _firestore.doc(path);
    final snapshot = firestoreRef.snapshots();
    print("dsdadasdas");
    snapshot.map(
      // (snapshot) => snapshot.docs.map(
      (snapshot) {
        final data = snapshot.data();
        user.setAddress(
            phone: data["phone"], city: data["city"], area: data["area"]);
      },
      // ),
    );
  }
}
