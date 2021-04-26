import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/service/Auth.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/service/storage_repo.dart';

class UserController {
  UserModel _currentUser;
  Auth _authRepo = locator.get<Auth>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();

  Future init;

  UserController() {
    _currentUser = initUser();
  }

  UserModel initUser() {
    _currentUser = _authRepo.currentUserModel();

    getDownloadUrl();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(PickedFile image) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(File(image.path));
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User user = await _authRepo.mysignInWithGoogle(context);
      _currentUser = UserModel.user(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      User user = await _authRepo.signInWithFacebook();
      _currentUser = UserModel.user(user);
      if (user.photoURL != null) {
        _currentUser.avatarUrl = user.photoURL;
      } else {
        print(user.photoURL);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getDownloadUrl() async {
    if (_currentUser.uid == null) {
      _currentUser.avatarUrl =
          await _storageRepo.getUserProfileImage(currentUser);
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

  void updateDisplayName(String displayName) {
    _currentUser.displayName = displayName;
    _authRepo.updateDisplayName(displayName);
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

  Future<void> singInAnonmymous() async {
    try {
      await _authRepo.singInAnonmymous();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<User> authStateChanges() => _authRepo.authStateChanges();
}
