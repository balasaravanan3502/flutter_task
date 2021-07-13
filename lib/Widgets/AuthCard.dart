import 'package:flutter/material.dart';
import 'package:flutter_task/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_task/constant.dart';
import 'package:flutter_task/Provider/Auth.dart';
import 'OAuth.dart';

class AuthCard extends StatefulWidget {
  final screen;
  final navigate;

  AuthCard(this.screen, this.navigate);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  void _submitted() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_email.text != '' && _password.text != '') {
      if (widget.screen == 'Sign In') {
        final provider = Provider.of<Auth>(context, listen: false);
        var res = await provider.signIn(_email.text, _password.text);
        if (res == 'Success') {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res),
            ),
          );
        }
      } else {
        if (_password.text == _confirmpassword.text) {
          final provider = Provider.of<Auth>(context, listen: false);
          var res = await provider.signUp(_email.text, _password.text);

          if (res == 'Success') {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(res),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Passwords does not match'),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter valid credentials'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .5,
          decoration: BoxDecoration(
            color: Color(0xCCffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Text(
                widget.screen,
                style: TextStyle(
                  color: Color(0xff1A2561),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffAC9E8C),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: TextFormField(
                        controller: _email,
                        style: TextStyle(color: Colors.white),
                        decoration: TextFieldDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        cursorColor: Color(0xff2D5C78),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffAC9E8C),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: TextFormField(
                        controller: _password,
                        style: TextStyle(color: Colors.white),
                        decoration: TextFieldDecoration.copyWith(
                          hintText: 'Password',
                        ),
                        cursorColor: Color(0xff2D5C78),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    if (widget.screen == 'Sign In')
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xff5D7A9C),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    if (widget.screen != 'Sign In')
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffAC9E8C),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: TextFormField(
                          controller: _confirmpassword,
                          style: TextStyle(color: Colors.white),
                          decoration: TextFieldDecoration.copyWith(
                            hintText: 'Re-enter Password',
                          ),
                          cursorColor: Color(0xff2D5C78),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    isLoading = true;
                    _submitted();
                    isLoading = false;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      widget.screen,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '            ',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Or ${widget.screen} With'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '            ',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OAuth('assets/icons/google.jpg', () {}),
                      OAuth('assets/icons/facebook.jpg', () {}),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an Account?'),
                        MaterialButton(
                          onPressed: widget.navigate,
                          child: Text(
                            widget.screen != 'Sign In' ? 'Sign In' : 'Sign Up',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
