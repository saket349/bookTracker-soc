import 'dart:convert';

import 'package:authentication/services/authservices.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future sendBook(
      String name, String author, String edition, bool isActive) async {
    final AuthService _auth = AuthService();
    dynamic currentUser = _auth.currentUser().uid;

    try {
      final http.Response response = await http.post(
        'https://65ba1da7c417.ngrok.io/book/post',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'author': author,
          'edition': edition,
          'isActive': isActive,
          'ownerID': currentUser
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        return {"message": jsonDecode(response.body), "success": true};
      } else {
        print(response.body);
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      return {"error": e, "success": false};
    }
  }

  Future updateProfile(String name, String year, String hostel, String dept,
      String room, int gender) async {
    final AuthService _auth = AuthService();
    dynamic currentUser = _auth.currentUser().uid;

    try {
      final http.Response response = await http.post(
        'https://65ba1da7c417.ngrok.io/person/post',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'hostel': hostel,
          'dept': dept,
          'room': room,
          'gender': gender,
          'year': year,
          'uid': currentUser
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        return {"message": jsonDecode(response.body), "success": true};
      } else {
        print(response.body);
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      return {"error": e, "success": false};
    }
  }

  // get books
  Future getBooks() async {
    final AuthService _auth = AuthService();
    dynamic currentUser = _auth.currentUser().uid;

    try {
      final http.Response response = await http.get(
        'https://65ba1da7c417.ngrok.io/book/list',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {"message": jsonDecode(response.body), "success": true};
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      return {"error": e, "success": false};
    }
  }

  // get

  // get books
  Future getmyBooks() async {
    final AuthService _auth = AuthService();
    dynamic currentUser = _auth.currentUser().uid;
    var queryParameters = {"id": currentUser};
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      final http.Response response = await http.get(
        'https://65ba1da7c417.ngrok.io/person/mybook' + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {"message": jsonDecode(response.body), "success": true};
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      return {"error": e, "success": false};
    }
  }

  //get profile
  // get books
  Future getmyProfile() async {
    final AuthService _auth = AuthService();
    dynamic currentUser = _auth.currentUser().uid;
    var queryParameters = {"id": currentUser};
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      final http.Response response = await http.get(
        'https://65ba1da7c417.ngrok.io/person/list' + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {"message": jsonDecode(response.body), "success": true};
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      return {"error": e, "success": false};
    }
  }

  Future deleteBook(String id) async {
    try {
      var queryParameters = {"id": id};
      String queryString = Uri(queryParameters: queryParameters).query;
      final http.Response response = await http.delete(
        'https://65ba1da7c417.ngrok.io/book/del' + '?' + queryString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        return {"message": jsonDecode(response.body), "success": true};
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);
      return {"error": e, "success": false};
    }
  }
}
