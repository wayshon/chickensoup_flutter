import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'cardInfo.dart';

const _SoupUrl = 'https://calcbit.com/resource/dujitang/jitang.json';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  var text = 'loading...';

  @override
  void initState() {
    super.initState();
    getSoups();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('一碗毒鸡汤'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: pushSaved),
          new IconButton(icon: new Icon(Icons.share), onPressed: share),
        ],
      ),
      body: buildContent(),
    );
  }

  buildContent() {
    return new CardInfo(text);
  }

  getSoups() async {
    final httpClient = new HttpClient();
    try {
      final request = await httpClient.getUrl(Uri.parse(_SoupUrl));
      final response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        final json = await response.transform(utf8.decoder).join();
        final res = jsonDecode(json);
        print(res['data'][5]['text']);
        setState(() {
          text = res['data'][5]['text'];
        });
      } else {
      }
    } catch (exception) {
      
    }
  }

  pushSaved() {

  }

  share() {

  }
}
