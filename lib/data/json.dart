import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_resto_ku/model/app/singleton_model.dart';

class Json {
  late SingletonModel _model;

  Json() {
    _model = SingletonModel.shared;
  }

  Future load({required String path}) async {
    try {
      return await DefaultAssetBundle.of(_model.context!).loadString(path);
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    }
  }
}
