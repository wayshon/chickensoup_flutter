import 'package:chickensoup_flutter/store/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'cardInfo.dart';
import 'dart:math';
import 'list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'components/toast.dart';

const _SoupUrl = 'https://calcbit.com/resource/dujitang/jitang.json';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  var isLoading = false;
  var text = '';
  var allList;
  CommonModel Model;

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
          new IconButton(icon: new Icon(Icons.list), onPressed: pushList),
        ],
      ),
      body: isLoading ? new Center(
        child: new SpinKitCubeGrid(color: Colors.blue)
      ) : buildContent()
    );
  }

  buildContent() {
    if (Model == null) {
      Model = Provider.of<CommonModel>(context);
    }
    Model.initList();
    return new CardInfo(text, Model.favorites, setRandomText, (favorites) {
      setState(() {
        Model.update(favorites);
      });
    });
  }

  setRandomText() {
    if (allList != null) {
      final index = Random().nextInt(allList.length);
      setState(() {
        text = allList[index]['text'];
      });
    }
  }

  getSoups() async {
    setState(() {
      isLoading = true;
    });
    final httpClient = new HttpClient();
    try {
      final request = await httpClient.getUrl(Uri.parse(_SoupUrl));
      final response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        final json = await response.transform(utf8.decoder).join();
        final res = jsonDecode(json);
        allList = res['data'];
        setRandomText();
      } else {
        Toast.show(context, '加载鸡汤失败 - ${response.statusCode}', duration: 3);
      }
    } catch (exception) {
      Toast.show(context, '加载鸡汤失败');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  pushList() async {
    final str = await Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new MySavedPage();
      })
    );
    setState(() {
      text = str;
    });
  }
}
