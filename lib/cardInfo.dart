import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final _textFont = const TextStyle(fontSize: 32.0);
  final String text;

  CardInfo(this.text);

  @override
  Widget build(BuildContext context) {
    return new Text(this.text, style: _textFont);
  }
}