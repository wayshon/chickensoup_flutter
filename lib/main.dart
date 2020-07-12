import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'store/common.dart';

void main() {
  final Model = new CommonModel();
  runApp(
    Provider<Set<String>>.value(
      value: null,
      child: ChangeNotifierProvider.value(
        value: Model,
        child: new MyApp(),
      ),
    )
  );

  // runApp(new MyApp())
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '一碗毒鸡汤',
      home: new Home(),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}