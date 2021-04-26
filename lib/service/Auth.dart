import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:souqy/model/user_model.dart';

abstract class AuthBase {
  User get currentUser;
  FirebaseAuth get firebase;

  UserModel currentUserModel();
  Future<User> singInAnonmymous();
  Stream<User> authStateChanges();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> updateDisplayName(String displayName);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> creatUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  FirebaseAuth get firebase => FirebaseAuth.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  User get currentUser => _firebaseAuth.currentUser;
  UserModel currentUserModel() {
    var user = _firebaseAuth.currentUser;
    return (user != null) ? UserModel.user(user) : null;
  }

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
  @override
  Future<User> singInAnonmymous() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    final signInGoogle = GoogleSignIn();
    await signInGoogle.signOut();
    final signInFacebook = FacebookLogin();
    await signInFacebook.logOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        {
          final accessToken = response.accessToken;
          final userCredential = await _firebaseAuth.signInWithCredential(
              FacebookAuthProvider.credential(accessToken.token));
          String url =
              "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${accessToken.token}";
          var graphResponse = await http.get(Uri.parse(url));
          var profile = json.decode(graphResponse.body);
          final User user = userCredential.user;
          await user.updateProfile(
            photoURL: profile['picture']['data']['url'],
          );
          await user.reload();
          return user;
        }
      case FacebookLoginStatus.cancel:
        {
          throw FirebaseAuthException(
            code: "ERROR_ABORTED_BY_USER",
            message: "Singin abort by user",
          );
        }
      case FacebookLoginStatus.error:
        {
          throw FirebaseAuthException(
            code: "ERROR_FACEBOOK_LOGIN_FAILED",
            message: response.error.developerMessage,
          );
        }
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        // User user = userCredential.user;

        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: "ERROR_MISSING_GOOGLE_ID_TOKEN",
          message: "Missing Google Id Token",
        );
      }
    } else {
      throw FirebaseAuthException(
        code: "ERROR_ABORTED_BY_USER",
        message: "Singin abort by user",
      );
    }
  }

  @override
  Future<User> creatUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return userCredential.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }

  Future<void> updateDisplayName(String displayName) async {
    var user = currentUser;

    user.updateProfile(
      displayName: displayName,
    );
  }

  Future<User> mysignInWithGoogle(BuildContext context) async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final GoogleAuthCredential googleAuthCredential =
            GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential =
            await _firebaseAuth.signInWithCredential(googleAuthCredential);
      }

      final User user = userCredential.user;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'welcome to souqy .\nSign In ${user.displayName} with Google.'),
      ));
      return user;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
      return null;
    }
  }
}
