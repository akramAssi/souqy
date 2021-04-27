import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/service/Auth.dart';
import 'package:souqy/service/database_repo.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/service/storage_repo.dart';

class UserController {
  UserModel _currentUser;
  Auth _authRepo = locator.get<Auth>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();
  FirestoreDatabase _databaseRepo = locator.get<FirestoreDatabase>();
  Future init;

  UserController() {
    _currentUser = initUser();
  }

  UserModel initUser() {
    _currentUser = _authRepo.currentUserModel();

    getDownloadUrl();
    return _currentUser;
  }

//user tool

  UserModel get currentUser => _currentUser;

  void updateDisplayName(String displayName) {
    _currentUser.displayName = displayName;
    _authRepo.updateDisplayName(displayName);
  }

  Stream<User> authStateChanges() => _authRepo.authStateChanges();

// sign tool

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User user = await _authRepo.mysignInWithGoogle(context);
      _currentUser = UserModel.user(user);
      await getDownloadUrl();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      User user = await _authRepo.signInWithFacebook();
      _currentUser = UserModel.user(user);
      getDownloadUrl();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    User user = await _authRepo.signInWithEmailAndPassword(email, password);
    _currentUser = UserModel.user(user);

    // _currentUser.avatarUrl = await getDownloadUrl();
  }

  Future<void> creatUserWithEmailAndPassword(
      {@required String name,
      @required String email,
      @required String password}) async {
    User user = await _authRepo.creatUserWithEmailAndPassword(email, password);
    await _authRepo.updateDisplayName(name);

    _currentUser = UserModel.user(user);
  }

  Future<void> singInAnonmymous() async {
    try {
      await _authRepo.singInAnonmymous();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepo.signOut();
      // locator.popScope();
      // setupServices();
    } catch (e) {
      print(e);
    }
  }

  //storage
  Future<void> uploadProfilePicture(PickedFile image) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(File(image.path));
  }

  Future<void> getDownloadUrl() async {
    if (_currentUser?.uid != null) {
      _currentUser.avatarUrl =
          await _storageRepo.getUserProfileImage(currentUser);
    }
  }

  //database

  Future<void> storeAddress(
      {@required String phone,
      @required String city,
      @required String area}) async {
    _currentUser.phone = phone;
    _currentUser.city = city;
    _currentUser.area = area;
    await _databaseRepo.storeUserInfo(_currentUser);
  }

  void readAddres() {
    _databaseRepo.readUserInfo(_currentUser);
  }
}
