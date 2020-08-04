import 'package:flutter/material.dart';
import 'package:scan_flutter_ios/scan_flutter_ios.dart';
import 'package:flutter/services.dart';

class CardInfo extends StatelessWidget {
  final _textFont = const TextStyle(fontSize: 32.0);
  final String text;
  final Set<String> favorites;
  final refreshText;
  final updateFavorites;

  CardInfo(this.text, this.favorites, this.refreshText, this.updateFavorites);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: buildContent(),
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('images/paperbg.jpeg'), fit: BoxFit.fill),
        ));
  }

  buildContent() {
    final isSaved = favorites.contains(text);
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
                    child: new GestureDetector(
                      onTap: () {
                        if (isSaved) {
                          favorites.remove(text);
                        } else {
                          favorites.add(text);
                        }
                        updateFavorites(favorites);
                      },
                      child: new Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: isSaved ? Colors.red : Colors.grey,
                        size: 48.0,
                      ),
                    )),
                new Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: new GestureDetector(
                      onTap: () async {
                        bool result;
                        try {
                          result = await ScanFlutterIos.share([
                            {
                              'text': '哈哈哈哈哈哈哈哈',
                              'url': 'https://calcbit.com',
                              'imageUrl':
                                  'https://calcbit.com/resource/doudou/doudou.jpeg'
                            }
                          ]);
                        } on PlatformException {
                          result = false;
                        }
                        print(result);
                      },
                      child: new Icon(
                        Icons.share,
                        color: Colors.blue,
                        size: 48.0,
                      ),
                    )),
                new Expanded(
                    child: new Container(
                  height: 48.0,
                  child: RaisedButton.icon(
                    icon: new Icon(Icons.refresh),
                    label: Text("再来一碗", style: TextStyle(fontSize: 18.0)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    onPressed: () {
                      if (refreshText != null) {
                        refreshText();
                      }
                    },
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
