import 'package:flutter/material.dart';

class SingletonModel {
  static final SingletonModel _singleton = SingletonModel._internal();

  factory SingletonModel() {
    return _singleton;
  }

  SingletonModel._internal();

  static SingletonModel withContext(BuildContext context) {
    _singleton.context = context;
    return _singleton;
  }

  static SingletonModel get shared => _singleton;

  BuildContext? context;
}
