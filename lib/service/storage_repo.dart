import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/service/Auth.dart';
import 'package:souqy/service/locator.dart';

class StorageRepo {
  // FirebaseStorage _storage =
  //     FirebaseStorage(bucket: "gs://souqy-9b821.appspot.com");
  FirebaseStorage _storage = FirebaseStorage.instance;

  // Auth _authRepo = locator.get<Auth>();
  Future<String> uploadFile(File file, String firebaseCloudPath) async {
    // UserModel user = _authRepo.currentUserModel();
    // var userId = user.uid;
    var storageRef = _storage.ref().child(firebaseCloudPath);
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(UserModel user) async {
    if (user?.uid == null) {
      return null;
    }

    Reference file = _storage.ref().child("user/profile/${user.uid}");
    String f = (await file.getDownloadURL()).toString();
    return f;
  }
}
