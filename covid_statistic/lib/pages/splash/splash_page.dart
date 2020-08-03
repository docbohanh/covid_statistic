import 'dart:async';
import 'package:covid_statistic/router/router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimeout() {
    return Timer(Duration(milliseconds: 500), changeScreen);
  }

  changeScreen() {
    navigatorKey.currentState.pushReplacementNamed(Routes.mainPage);
  }

  @override
  void initState() {
    super.initState();

    startTimeout();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }
}