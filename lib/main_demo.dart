import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
      theme: new ThemeData(
        primaryColor: Colors.orange,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new MySavedPage(_saved.toList());
        }
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      // 在偶数行，该函数会为单词对添加一个ListTile row.
      // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder: (context, i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (i.isOdd) return new Divider();

        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    // return new ListTile(
    //   title: new Text(
    //     pair.asPascalCase,
    //     style: _biggerFont,
    //   ),
    //   trailing: new Icon(
    //     alreadySaved ? Icons.favorite : Icons.favorite_border,
    //     color: alreadySaved ? Colors.red : null,
    //   ),
    //   onTap: () {
    //     setState(() {
    //       if (alreadySaved) {
    //         _saved.remove(pair);
    //       } else {
    //         _saved.add(pair);
    //       }
    //     });
    //   },
      // );

    return new Cell(pair, true, alreadySaved, (p) => {
      setState(() {
        if (alreadySaved) {
          _saved.remove(p);
        } else {
          _saved.add(p);
        }
      })
    });
  }
}

class MySavedPage extends StatelessWidget {
  final List<WordPair> pairs;

  MySavedPage(this.pairs);

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('我的收藏'),
      ),
      body: buildList(context),
    );
  }

  Widget buildList(context) {
    // final titles = pairs.map((pair) => new Text(pair.asPascalCase,style: const TextStyle(fontSize: 18.0,height: 3.0)));
    final titles = pairs.map((pair) => new Cell(pair, false, false, () => {}));
    final divided = ListTile.divideTiles(tiles: titles, context: context).toList();
    return new ListView(children: divided);
  }
}

class Cell extends StatelessWidget {
  final WordPair pair;
  final bool showIcon;
  final bool isSaved;
  final onTap;
  
  Cell(this.pair, this.showIcon, this.isSaved, this.onTap);

  @override
  Widget build(BuildContext context) {
    final _biggerFont = const TextStyle(fontSize: 18.0);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: showIcon ? new Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ) : null,
      onTap: showIcon ? () {
        onTap(pair);
      } : null,
    );
  }
}