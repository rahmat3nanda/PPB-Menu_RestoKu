import 'package:menu_resto_ku/common/configs.dart';
import 'package:menu_resto_ku/common/constans.dart';
import 'package:menu_resto_ku/common/styles.dart';
import 'package:menu_resto_ku/page/splash_page.dart';
import 'package:flutter/material.dart';

class MenuRestoKu extends StatelessWidget {
  const MenuRestoKu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kGAppName,
      theme: tdMain,
      localizationsDelegates: kLDelegates,
      supportedLocales: kLSupports,
      home: const SplashPage(),
    );
  }
}