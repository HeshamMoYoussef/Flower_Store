import 'package:flutter/material.dart';

const decorationTextField = InputDecoration(
  // To delete borders
  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey),
  ),
  fillColor: Colors.black12,
  filled: true,
  contentPadding: EdgeInsets.all(8),
);

const btnPink = Color.fromARGB(255, 241, 39, 100);
const btnGreen = Color.fromARGB(255, 73, 179, 105);
const appBarGreen = Color.fromARGB(255, 76, 141, 95);
