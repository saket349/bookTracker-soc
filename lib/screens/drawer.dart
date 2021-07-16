import 'package:authentication/screens/addbook.dart';
import 'package:authentication/screens/mybooks.dart';
import 'package:authentication/screens/profile.dart';
import 'package:authentication/services/authservices.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 10),
                  child: CircleAvatar(
                    child: Icon(Icons.person, color: Colors.black),
                    radius: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 10),
                  child: Text(
                    _auth.currentUser().email,
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: Image.network(
                            "https://cdn.pixabay.com/photo/2018/03/27/14/37/design-3266151_960_720.png")
                        .image)),
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Welcome'),
          //   onTap: () => {},
          // ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Book'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBook()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('My Books'),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyBooks()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_auth.signout(context)},
          ),
        ],
      ),
    );
  }
}
