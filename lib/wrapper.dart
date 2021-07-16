import 'package:authentication/screens/authentication.dart';
import 'package:authentication/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);

    if (firebaseUser == null) {
      return AuthenticationPage();
    } else {
      return Home();
    }
  }
}
