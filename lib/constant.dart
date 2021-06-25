import 'package:flutter/material.dart';

const TextFieldDecoration = InputDecoration(
  hintText: 'Hint',
  hintStyle: TextStyle(color: Colors.white),
  fillColor: Colors.black,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
  contentPadding: EdgeInsets.symmetric(
    vertical: 6.0,
    horizontal: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
);
