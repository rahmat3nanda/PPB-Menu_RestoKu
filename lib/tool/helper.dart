import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money2/money2.dart';

class Helper {
  Future exitApp() {
    return Platform.isIOS ? exit(0) : SystemNavigator.pop(animated: true);
  }

  Future jumpToPage(BuildContext context, {required Widget page}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  Future moveToPage(BuildContext context, {required Widget page}) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void backToRootPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  String formatRupiah(String n) {
    final Currency idr = Currency.create(
      'IDR',
      0,
      symbol: 'Rp',
      pattern: n.length != 1 ? 'S 0.000' : 'S 0',
      invertSeparators: true,
    );
    Money output = Money.fromInt(int.parse(n), idr);
    return output.toString();
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}