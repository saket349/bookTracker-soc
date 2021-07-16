import 'package:authentication/screens/book.dart';
import 'package:authentication/screens/drawer.dart';
import 'package:authentication/services/http.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  restart() async {
    await getBooks();
    print("helo");
    setState(() {});
  }

  getBooks() async {
    final HttpService _httpService = HttpService();
    dynamic response = await _httpService.getBooks();

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
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {});
                  getBooks();
                  setState(() {});
                },
                child: Icon(Icons.refresh),
                backgroundColor: Colors.redAccent),
            drawer: NavDrawer(),
            backgroundColor: Colors.white,
            appBar: AppBar(title: Text("Home"), backgroundColor: Colors.indigo),
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
