import 'package:menu_resto_ku/common/constans.dart';
import 'package:menu_resto_ku/common/styles.dart';
import 'package:menu_resto_ku/model/app/singleton_model.dart';
import 'package:menu_resto_ku/page/home_page.dart';
import 'package:menu_resto_ku/tool/helper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Helper _helper;

  @override
  void initState() {
    super.initState();
    SingletonModel.withContext(context);
    _helper = Helper();
    _toHome();
  }

  void _toHome() async {
    await Future.delayed(const Duration(seconds: 2));
    _helper.moveToPage(context, page: const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            kGAppName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
