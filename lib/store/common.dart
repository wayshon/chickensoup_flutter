import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LOCAL_DATA_KEY = 'favorites';

class CommonModel with ChangeNotifier {
  Future<SharedPreferences> _prefs;
  var _list = new Set<String>();

  Future<SharedPreferences> get prefs {
    if (_prefs == null) {
      _prefs = SharedPreferences.getInstance();
    }
    return _prefs;
  }

  Set<String> get favorites => _list;

  initList() async {
    final SharedPreferences storage = await prefs;
    final list = storage.getStringList(LOCAL_DATA_KEY);
    if (list != null) {
      _list = list.toSet();
      notifyListeners();
    }
  }

  saveList(list) async {
    final SharedPreferences storage = await prefs;
    storage.setStringList(LOCAL_DATA_KEY, list.toList());
  }

  void update(list) async {
    _list = list;
    saveList(_list);
    notifyListeners();
  }

  void add(v) async {
    _list.add(v);
    saveList(_list);
    notifyListeners();
  }

  void remove(v) async {
    _list.remove(v);
    saveList(_list);
    notifyListeners();
  }
}