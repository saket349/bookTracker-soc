import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//sign In With Google
  Future<UserCredential> signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print(googleUser);
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print(googleAuth);
      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Navigator.pop(context);
      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }

//sign in with email and password

  Future signInWithEmailAndPasword(
      String email, String password, context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);

      // ignore: deprecated_member_use
      dynamic user = result.user.email;
      // Navigator.pop(context);

      return {"user": user, "success": true};
    } on FirebaseAuthException catch (e) {
      print(e);
      return {"success": false, "error": e.message};
    } catch (e) {
      return {"success": false, "error": e};
    }
  }

  //register with email and password
  Future registerwithEmailAndPassword(
      String email, String password, context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // ignore: deprecated_member_use
      dynamic user = result.user.email;
      Navigator.pop(context);

      return {"user": user, "success": true};
    } on FirebaseAuthException catch (e) {
      print(e);
      return {"success": false, "error": e.message};
    } catch (e) {
      return {"success": false, "error": e};
    }
  }

  //signout

  Future signout(context) async {
    try {
      if (_auth.currentUser.providerData[0].providerId == 'google.com') {
        await _googleSignIn.signOut();
      }
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  currentUser() {
    return _auth.currentUser;
  }

  //Using Stream to listen to Authentication State
  Stream get authState => _auth.authStateChanges();
  Stream get User {
    return _auth.authStateChanges();
  }
}
