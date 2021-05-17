import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/model/user_model.dart';
import 'package:souqy/service/Auth.dart';
import 'package:souqy/service/database_repo.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/service/storage_repo.dart';
import 'package:souqy/service/firebase_auth_exceptions_handling.dart';

class UserController {
  UserModel _currentUser;
  AuthResultStatus _status;

  Auth _authRepo = locator.get<Auth>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();
  FirestoreDatabase _databaseRepo = locator.get<FirestoreDatabase>();
  Future init;

  UserController() {
    _currentUser = initUser();
  }

  UserModel initUser() {
    _currentUser = _authRepo.currentUserModel();
    return _currentUser;
  }

  Future<void> refresh() async {
    _currentUser = _authRepo.currentUserModel();

    getDownloadUrl();
    if (_currentUser != null) {
      await readAddres();
    }
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
      // UserModel tempUser = UserModel.user(user);
      _currentUser = UserModel.user(user);
      await readAddres();
      if (_currentUser.displayName == null ||
          _currentUser.displayName.isEmpty) {
        _currentUser.displayName = user.displayName;
        storeSelf();
      }
      await getDownloadUrl();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      User user = await _authRepo.signInWithFacebook();
      _currentUser = UserModel.user(user);
      await readAddres();
      if (_currentUser.displayName == null ||
          _currentUser.displayName.isEmpty) {
        _currentUser.displayName = user.displayName;
        print("eeeokko:${_currentUser.displayName}");
        storeSelf();
      }
      getDownloadUrl();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AuthResultStatus> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      User user = await _authRepo.signInWithEmailAndPassword(email, password);
      if (user != null) {
        _status = AuthResultStatus.successful;
        _currentUser = UserModel.user(user);
        await readAddres();
        if (_currentUser.displayName == null ||
            _currentUser.displayName.isEmpty) {
          _currentUser.displayName = user.displayName;
          print("eeeokko:${_currentUser.displayName}");
          storeSelf();
        }
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
    // _currentUser.avatarUrl = await getDownloadUrl();
  }

  Future<AuthResultStatus> creatUserWithEmailAndPassword({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) async {
    try {
      User user =
          await _authRepo.creatUserWithEmailAndPassword(email, password);
      // user = await _authRepo.updateDisplayName(name);
      // _currentUser = UserModel.user(user);

      // return false;
      storeAddress(name: name, phone: phone, email: email);

      if (user != null) {
        _status = AuthResultStatus.successful;
        _currentUser = UserModel.user(user);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<void> singInAnonmymous() async {
    await _authRepo.singInAnonmymous();
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
    // locator.popScope();
    // setupServices();
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
      {@required String name,
      @required String email,
      @required String phone,
      String city,
      String area}) async {
    UserModel temp = UserModel(
      _currentUser.uid,
      avatarUrl: _currentUser.avatarUrl,
      displayName: name,
      email: email,
      phone: phone,
      city: city,
      area: area,
    );
    await _databaseRepo.storeUserInfo(temp).then((value) {
      _currentUser = temp;
      // _currentUser.email = email ?? "";
      // _currentUser.phone = phone ?? "";
      // _currentUser.city = city ?? "";
      // _currentUser.area = area ?? "";
    });
  }

  Future<void> storeSelf() async {
    await _databaseRepo.storeUserInfo(_currentUser);
  }

  Future<void> readAddres() async {
    await _databaseRepo.readUserInfo(_currentUser);
  }
}
