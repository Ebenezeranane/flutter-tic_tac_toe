//Tic Tac Toe Game
//Developed by awedev

import 'package:tic_tac_toe/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: Homepage(),
    ));
  }
}
