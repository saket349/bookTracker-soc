import 'package:authentication/screens/detailedview.dart';
import 'package:authentication/services/authservices.dart';
import 'package:authentication/services/http.dart';
import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  String name;
  String edition;
  String author;
  bool isAvailable;
  String id;
  String _uid;
  Function restart;

  Book(this._uid, this.name, this.author, this.edition, this.isAvailable,
      this.id, this.restart);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    dynamic currentUser = _auth.currentUser().uid;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedView(widget.name, widget.author,
                  widget.edition, widget.isAvailable)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 10,
            child: ListTile(
              title: Text(widget.name.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Edition: ${widget.edition.toString()}'),
              trailing: currentUser == widget.id
                  ? IconButton(
                      onPressed: () {
                        final HttpService _httpService = HttpService();
                        _httpService.deleteBook(widget._uid);

                        widget.restart();

                        setState(() {});
                      },
                      icon: Icon(Icons.delete, color: Colors.red))
                  : null,
              leading: widget.isAvailable
                  ? Icon(Icons.circle, color: Colors.blue)
                  : Icon(Icons.circle, color: Colors.green),
            )),
      ),
    );
  }
}
