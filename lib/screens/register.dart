import 'package:authentication/services/authservices.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ignore: deprecated_member_use

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _rePassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _rePassword.dispose();
    super.dispose();
  }

  bool _paswordVisibiltyToggler = true;

  Icon _passwordVisibilty() {
    if (!_paswordVisibiltyToggler) {
      return Icon(Icons.visibility);
    } else {
      return Icon(Icons.visibility_off);
    }
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
                                'Register',
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
                  Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 18),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: "Emailid",
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Color.fromRGBO(229, 229, 229, 1),
                              filled: true

                              //fillColor: Colors.green
                              ),
                          validator: (val) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val);
                            if (!emailValid) {
                              return "Use valid  Email id ";
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
                            vertical: 15.0, horizontal: 18),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Set Password",
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Color.fromRGBO(229, 229, 229, 1),
                              filled: true

                              //fillColor: Colors.green
                              ),
                          validator: (val) {
                            if (val.length < 5) {
                              return "password length must be atleast 6 ";
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 18),
                        child: TextFormField(
                          controller: _rePassword,
                          obscureText: _paswordVisibiltyToggler,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              child: _passwordVisibilty(),
                              onTap: () {
                                setState(() {
                                  _paswordVisibiltyToggler =
                                      !_paswordVisibiltyToggler;
                                });
                              },
                            ),
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(229, 229, 229, 1),

                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val != _password.text) {
                              return "Passwords Not Matched";
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
                                    await _auth.registerwithEmailAndPassword(
                                        _email.text, _password.text, context);

                                    _rePassword.clear();
                                    _password.clear();
                                    _email.clear();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Register',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 30),
                        child: Container(
                          alignment: Alignment.topRight,
                          //color: Colors.red,
                          height: 28,
                        ),
                      )
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
