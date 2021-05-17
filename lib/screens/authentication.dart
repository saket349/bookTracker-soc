import 'package:authentication/screens/googlesignin.dart';
import 'package:authentication/screens/register.dart';
import 'package:authentication/screens/signin.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 309,
                  height: 102,
                  child: Center(
                    child: Text(
                      "BOOK TRACKER",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontFamily: "Gotham"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Container(
                  child: Center(
                    child: FlatButton(
                      minWidth: 189,
                      height: 56,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "New here?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      color: Color.fromRGBO(56, 166, 167, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Center(
                    child: FlatButton(
                      minWidth: 189,
                      height: 56,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      color: Color.fromRGBO(36, 130, 140, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                GoogleSignIn()
              ])),
    );
  }
}
