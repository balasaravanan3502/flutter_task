import 'package:flutter/material.dart';

class OAuth extends StatelessWidget {
  final String imagePath;
  final onPressed;

  OAuth(this.imagePath, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        radius: MediaQuery.of(context).size.width * .038,
      ),
      onPressed: onPressed,
    );
  }
}
