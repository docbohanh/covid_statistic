import 'package:covid_statistic/helper/color_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool isLoading = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          child: isLoading
              ? Center(child: ColorLoader())
              : Container(),
        ),
      ),
    );
  }
}
