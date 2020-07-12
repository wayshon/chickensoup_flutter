import 'package:chickensoup_flutter/cardInfo.dart';
import 'package:chickensoup_flutter/store/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('喜欢'),
      ),
      body: buildContent(context),
    );
  }

  buildContent(context) {
    return new Container(
      child: buildList(context),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('images/paperbg.jpeg'),
          fit: BoxFit.fill
        ),
      )
    );
  }

  Widget buildList(context) {
    final Model = Provider.of<CommonModel>(context);
    final showList = Model.favorites.toList();
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: showList.length,
      itemBuilder: (context, i) {
        final showText = showList[i];
        final List<Widget> renderList = [
          new Dismissible(
            key: Key('${showText}_$i'),
            direction: DismissDirection.endToStart,
            child: new Cell(showText, (t) {}),
            background: new Container(
              color: Colors.red,
              child: new ListTile(
                trailing: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )
            ),
            onDismissed: (direction) {
              Model.remove(showText);
            },
          ) 
        ];
        if (i > 0) {
          renderList.insert(0, new Divider());
        }
        return new Column(
          children: renderList
        );
      }
    );
  }
}

class Cell extends StatelessWidget {
  final String text;
  final onTap;
  
  Cell(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    final _biggerFont = const TextStyle(fontSize: 18.0);
    return new ListTile(
      title: new Text(
        text,
        style: _biggerFont,
      ),
      onTap: () {
        Navigator.of(context).pop(text);
      },
    );
  }
}