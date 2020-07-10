import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '一碗毒鸡汤',
      home: new Home(),
      theme: new ThemeData(
        primaryColor: Colors.orange,
      ),
    );
  }
}