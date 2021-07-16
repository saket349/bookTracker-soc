import 'package:authentication/screens/book.dart';
import 'package:authentication/screens/drawer.dart';
import 'package:authentication/services/http.dart';
import 'package:flutter/material.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({Key key}) : super(key: key);

  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  restart() async {
    await getBooks();
    print("helo");
    setState(() {});
  }

  getBooks() async {
    final HttpService _httpService = HttpService();
    dynamic response = await _httpService.getmyBooks();

    setState(() {
      books = response["message"]["user"];
      if (books.length == 0) {
        isNoBook = true;
      }
    });
  }

  List books = [];
  bool isNoBook = false;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar:
                AppBar(title: Text("My Books"), backgroundColor: Colors.indigo),
            body: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  if (isNoBook) {
                    return Center(child: Text("No Books"));
                  } else {
                    if (books.length == 0) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Book(
                        books[index]["_id"],
                        books[index]["name"],
                        books[index]["author"],
                        books[index]["edition"],
                        books[index]["isActive"],
                        books[index]["ownerID"],
                        restart);
                  }
                })));
  }
}
