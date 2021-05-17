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
      Navigator.pop(context);
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

      if (!result.user.emailVerified) {
        result.user.sendEmailVerification();

        _auth.signOut();
        return null;
      }
      // ignore: deprecated_member_use
      dynamic user = result.user.email;
      Navigator.pop(context);

      return user;
    } on FirebaseAuthException catch (e) {
      return null;
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

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
      } else {}
      return null;
    } catch (e) {
      return null;
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

  Stream get User {
    return _auth.authStateChanges();
  }
}
