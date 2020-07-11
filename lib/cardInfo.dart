import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final _textFont = const TextStyle(fontSize: 32.0);
  final String text;
  final bool isSaved;

  CardInfo(this.text, this.isSaved);

  @override
  Widget build(BuildContext context) {
    Widget TextSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Column(
        children: <Widget>[
          new Expanded(child: new Text(this.text, style: _textFont)),
          new Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: new Row(
              children: <Widget>[
                new Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: new Icon(
                  isSaved ? Icons.favorite : Icons.favorite_border,
                  color: isSaved ? Colors.red : null,
                  size: 48.0,
                )),
                new Expanded(child: new Container(
                  height: 48.0,
                  child: RaisedButton.icon(
                    icon: new Icon(Icons.refresh),
                    label: Text("再来一碗", style: TextStyle(fontSize: 18.0)),
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                    onPressed: () {},
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
//    new Text(this.text, style: _textFont)
    return TextSection;
  }
}