import 'package:authentication/services/http.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _name = TextEditingController();
  TextEditingController _author = TextEditingController();
  TextEditingController _edition = TextEditingController();
  bool _isAvailable = true;

  final HttpService _httpService = HttpService();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar:
                AppBar(title: Text("Add Book"), backgroundColor: Colors.indigo),
            body: ListView(children: <Widget>[
              SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                            labelText: "Book Name",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "name cannot be empty";
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
                      SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFormField(
                          controller: _author,
                          decoration: InputDecoration(
                            labelText: "Author ",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Author cannot be empty";
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
                      SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFormField(
                          controller: _edition,
                          decoration: InputDecoration(
                            labelText: "Edition",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Edition cannot be empty";
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Availability"),
                            Switch(
                              value: _isAvailable,
                              onChanged: (value) {
                                setState(() {
                                  _isAvailable = value;
                                });
                              },
                            ),
                          ]),
                      FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              final message = await _httpService.sendBook(
                                  _name.text,
                                  _author.text,
                                  _edition.text,
                                  _isAvailable);
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
                                _edition.clear();
                                _author.clear();
                              }
                            }
                          },
                          child: Text("Add",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.indigo)
                    ]),
                  ))
            ])));
  }
}
