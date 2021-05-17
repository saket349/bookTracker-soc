import 'package:authentication/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _verificationEmail = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _verificationEmail.dispose();
    super.dispose();
  }

  bool _paswordVisibiltyToggler = true;

  passwordResetStatus(message) {
    // ignore: missing_required_param
    showDialog(
        builder: (context) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: AlertDialog(
                content: Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
        context: context);
  }

  Icon _passwordVisibilty() {
    if (!_paswordVisibiltyToggler) {
      return Icon(Icons.visibility);
    } else {
      return Icon(Icons.visibility_off);
    }
  }

  _sendPasswordResetMail(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Text(
                    "Enter Your Registerd  MailId ! Password Reset Mail will be sent",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 10)),
              ],
            ),
            content: Form(
              key: _formKey1,
              child: TextFormField(
                controller: _verificationEmail,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.mail),
                  labelText: "Ldap Emailid",
                  fillColor: Colors.white10,
                  labelStyle: TextStyle(color: Colors.white60),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "IITb Emailid filed be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    if (_formKey1.currentState.validate()) {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      _auth
                          .sendPasswordResetEmail(
                              email: _verificationEmail.text)
                          .then((value) =>
                              passwordResetStatus("Successfully Sent"))
                          .catchError((onError) =>
                              passwordResetStatus(onError.code.toString()));
                    }
                    _verificationEmail.clear();
                  },
                  child: Text("Send", style: TextStyle(color: Colors.blue))),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.red)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(229, 229, 229, 1),
                  Color.fromRGBO(229, 229, 229, 0.5)
                ]),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 75),
                          child: Container(
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Color.fromRGBO(56, 166, 167, 1),
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),

                  //

                  Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 18),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            labelText: "Emailid",
                            fillColor: Color.fromRGBO(229, 229, 229, 1),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Emailid cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 18),
                        child: TextFormField(
                          controller: _password,
                          obscureText: _paswordVisibiltyToggler,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: _passwordVisibilty(),
                              onTap: () {
                                setState(() {
                                  _paswordVisibiltyToggler =
                                      !_paswordVisibiltyToggler;
                                });
                              },
                            ),
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(229, 229, 229, 1),

                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "password cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            _sendPasswordResetMail(context);
                          },
                          child: Container(
                            child: Text("Forgot password?"),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(56, 166, 167, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: FlatButton(
                                onPressed: () async {
                                  final _isvalid =
                                      _formKey.currentState.validate();

                                  if (_isvalid) {
                                    await _auth.signInWithEmailAndPasword(
                                        _email.text, _password.text, context);
                                    _password.clear();
                                    _email.clear();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
