import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/model/ads.dart';
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
  bool isAnonymous() {
    return _authRepo.isAnonymous;
  }

  UserModel initUser() {
    _currentUser = _authRepo.currentUserModel();

    return _currentUser;
  }

  Future<void> refresh() async {
    _currentUser = _authRepo.currentUserModel();

    //print("USer Url:${_currentUser.avatarUrl}");
    if (_currentUser != null) {
      _currentUser =
          await readUserInfo(_currentUser.uid, currentUser: currentUser);
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
      _currentUser =
          await readUserInfo(_currentUser.uid, currentUser: currentUser);
      if (_currentUser == null) {
        _currentUser = UserModel.user(user);
        await storeSelf();
        _currentUser.avatarUrl = await getDownloadUrl();
      }
    } catch (e) {
      print("akram error $e");
    }
  }

  Future<String> readUrl() async {
    var s = await _databaseRepo.readUrl();
    return s;
  }

  Future<void> signInWithFacebook() async {
    try {
      User user = await _authRepo.signInWithFacebook();
      _currentUser = UserModel.user(user);
      _currentUser =
          await readUserInfo(_currentUser.uid, currentUser: currentUser);
      if (_currentUser == null) {
        _currentUser = UserModel.user(user);
        await storeSelf();
        _currentUser.avatarUrl = await getDownloadUrl();
      }
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
        _currentUser =
            await readUserInfo(_currentUser.uid, currentUser: currentUser);
        if (_currentUser == null) {
          _currentUser = UserModel.user(user);
          await storeSelf();
          _currentUser.avatarUrl = await getDownloadUrl();
        }
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
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
      user = await _authRepo.updateDisplayName(name);
      _currentUser = UserModel.user(user);

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
    _currentUser = null;
    // locator.popScope();
    // setupServices();
  }

  //storage
  Future<void> uploadProfilePicture(PickedFile image) async {
    String path = "user/profile/${_currentUser.uid}";
    _currentUser.avatarUrl =
        await _storageRepo.uploadFile(File(image.path), path);
  }

  Future<String> getDownloadUrl() async {
    if (_currentUser?.uid != null) {
      try {
        return await _storageRepo.getUserProfileImage(currentUser);
      } catch (e) {
        return _authRepo.currentUser.photoURL;
      }
    }
    return null;
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
    });
  }

  Future<void> storeSelf() async {
    await _databaseRepo.storeUserInfo(_currentUser);
  }

  Future<UserModel> readUserInfo(String userId, {UserModel currentUser}) async {
    try {
      Map<String, dynamic> userJson = await _databaseRepo.readUserInfo(userId);
      if (userJson != null) {
        var x = UserModel.fromJson(userId, userJson, currentUser: currentUser);

        x.bookmark = await _databaseRepo.readUserBookmark(userId);
        x.avatarUrl = await getDownloadUrl();
        return x;
      }
    } catch (e) {
      print("akram error $e");
      return null;
    }
    return null;
  }

  Future<void> updateBookmarkUser() async {
    _currentUser.bookmark =
        await _databaseRepo.readUserBookmark(_currentUser.uid);
  }

  Future<void> addBookmark(String adsId) async {
    await _databaseRepo.addBookmark(adsId, _currentUser.uid);
    await updateBookmarkUser();
  }

  Future<void> deleteBookmarkUser(String adsId) async {
    await _databaseRepo.deleteUserBookmark(_currentUser.uid, adsId);
    await updateBookmarkUser();
  }

  Future<List<Ads>> getUserBookmark() async {
    var x = await _databaseRepo.readBookmark(_currentUser.bookmark);

    return x;
  }
}
