import 'package:authentication/services/http.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _name = TextEditingController();
  TextEditingController _year = TextEditingController();
  // TextEditingController _email = TextEditingController();
  List gender = [0, 1, 2];
  int select = 0;
  TextEditingController _hostel = TextEditingController();
  TextEditingController _dept = TextEditingController();
  TextEditingController _room = TextEditingController();

  getProfile() async {
    final HttpService _httpService = HttpService();
    dynamic response = await _httpService.getmyProfile();

    if (response['message']['count'] > 0) {
      var profile = response['message']['user'][0];
      print(profile);
      setState(() {
        _name.text = profile['name'];
        _hostel.text = profile['hostel'];
        _year.text = profile['year'];
        _room.text = profile['room'];
        _dept.text = profile['dept'];
        select = profile['gender'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();
  final HttpService _httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.indigo),
      body: ListView(
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Color.fromRGBO(229, 229, 229, 1),
                          filled: true

                          //fillColor: Colors.green
                          ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Name Required ";
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _year,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: "Year",
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Color.fromRGBO(229, 229, 229, 1),
                          filled: true

                          //fillColor: Colors.green
                          ),
                      validator: (val) {
                        if (int.parse(val) < 2000 || int.parse(val) > 2021) {
                          return "Valid Joining Year  Required ";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _hostel,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          labelText: "Hostel",
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Color.fromRGBO(229, 229, 229, 1),
                          filled: true

                          //fillColor: Colors.green
                          ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Hostel Required ";
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dept,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.group),
                          labelText: "Department",
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Color.fromRGBO(229, 229, 229, 1),
                          filled: true

                          //fillColor: Colors.green
                          ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Department Required ";
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _room,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.room),
                          labelText: "Room No",
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Color.fromRGBO(229, 229, 229, 1),
                          filled: true

                          //fillColor: Colors.green
                          ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Room No Required ";
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      addRadioButton(0, 'Male'),
                      addRadioButton(1, 'Female'),
                      addRadioButton(2, 'Others'),
                    ],
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final message = await _httpService.updateProfile(
                              _name.text,
                              _year.text,
                              _hostel.text,
                              _dept.text,
                              _room.text,
                              select);
                          if (!message["success"]) {
                            final snackBar = SnackBar(
                              content: Text(message["error"].toString()),
                              action: SnackBarAction(
                                label: 'cancel',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: Text(
                                  message["message"]["message"].toString()),
                              action: SnackBarAction(
                                label: 'cancel',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            _name.clear();
                            _hostel.clear();
                            _dept.clear();
                            _room.clear();
                            _year.clear();
                          }
                        }
                      },
                      child:
                          Text("Save", style: TextStyle(color: Colors.white)),
                      color: Colors.indigo)
                ],
              ))
        ],
      ),
    ));
  }
}
