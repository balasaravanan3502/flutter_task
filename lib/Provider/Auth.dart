import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<String> signUp(String email, String password) async {
    final url = 'https://nodejs-register-login-app.herokuapp.com/';

    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': 'test',
        'password': password,
        'passwordConf': password,
      }),
    );

    var res = json.decode(response.body)['Success'];

    if (res == 'You are regestered,You can login now.') {
      final SharedPreferences sharedpref =
          await SharedPreferences.getInstance();
      sharedpref.setBool('isLogged', true);

      return 'Success';
    }
    return res;
  }

  Future<String> signIn(String email, String password) async {
    final url = 'https://nodejs-register-login-app.herokuapp.com/login';

    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': 'test',
        'password': password,
        'passwordConf': password,
      }),
    );

    var res = json.decode(response.body)['Success'];

    if (res == 'Success!') {
      final SharedPreferences sharedpref =
          await SharedPreferences.getInstance();
      sharedpref.setBool('isLogged', true);
      return 'Success';
    }
    return res;
  }
}
