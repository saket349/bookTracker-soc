import 'package:flutter/material.dart';

class DetailedView extends StatefulWidget {
  String name;
  String edition;
  String author;
  bool isAvailable;

  DetailedView(this.name, this.author, this.edition, this.isAvailable);

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:
          AppBar(title: Text("Book Details"), backgroundColor: Colors.indigo),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Book Name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(width: 10),
                    Text(widget.name)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Issued By:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(width: 10),
                    Text(widget.author)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Edition:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(width: 10),
                    Text(widget.edition.toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Stauts:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(width: 10),
                    Text(widget.isAvailable.toString())
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    ));
  }
}
