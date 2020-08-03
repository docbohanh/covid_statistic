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
    return Timer(Duration(milliseconds: 1000), changeScreen);
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
      body: CurvedTransition(
        firstWidget: Container(color: Colors.white),
        secondWidget: Container(color: Color(0xFFF2F3F8)),
        transitionDuration: 1000,
        curve: Curves.bounceInOut,
      ),
    );
  }
}

///
///
/// Cross fading transition between two widgets. This uses the Flutter
/// way to make an animation.
///
///
class CurvedTransition extends StatefulWidget {
  const CurvedTransition(
      {@required this.firstWidget,
        @required this.secondWidget,
        @required this.transitionDuration,
        Key key,
        this.curve})
      : assert(firstWidget != null, 'The firstWidget argument is null.'),
        assert(secondWidget != null, 'The secondWidget argument is null.'),
        assert(transitionDuration != null,
        'The transitionDuration argument is null.'),
        super(key: key);

  final Widget firstWidget;
  final Widget secondWidget;
  final int transitionDuration;
  final Curve curve;

  @override
  _CurvedTransitionState createState() {
    return _CurvedTransitionState();
  }
}

class _CurvedTransitionState extends State<CurvedTransition>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation animationCurve;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: widget.transitionDuration),
        vsync: this);
    animationCurve = CurvedAnimation(parent: controller, curve: widget.curve)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 1.0 - animationCurve.value,
              child: widget.firstWidget,
            ),
            Opacity(
              opacity: animationCurve.value,
              child: widget.secondWidget,
            ),
          ],
        ));
  }
}
