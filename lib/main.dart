import 'package:flutter/material.dart';
import 'package:flutter_task/Screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

import 'Screens/SignUpScreen.dart';
import 'Screens/SigninScreen.dart';
import 'package:flutter_task/Provider/Auth.dart';
import 'package:flutter_task/Provider/News.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: News(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          SignUpScreen.routeName: (context) => SignUpScreen(),
          SignInScreen.routeName: (context) => SignInScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        },
        home: LandingScreen(),
      ),
    );
  }
}

class LandingScreen extends StatelessWidget {
  void initState() {
    landingPageDecider();
  }

  Future<String> landingPageDecider() async {
    var logindata = await SharedPreferences.getInstance();

    if (logindata.getBool('isLogged') == true) {
      return 'home';
    }

    return 'signIn';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: landingPageDecider(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data == 'home') return HomeScreen();

          return SignInScreen();
        });
  }
}
