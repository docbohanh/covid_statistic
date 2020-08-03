import 'package:covid_statistic/helper/hud.dart';
import 'package:covid_statistic/pages/main/main_page.dart';
import 'package:covid_statistic/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'page_route.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = 'splash_screen';
  static const String mainPage = 'MainPage';
}

class Argument {
  static const String title = 'title';
}

MaterialPageRoute hudableMaterialPageRoute({String settingName, Widget page}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: settingName),
    builder: (context) => ProgressHud(
      child: page,
    ),
  );
}

///
Route<dynamic> generateRoute(RouteSettings settings) {
  final Map args = settings.arguments;

  switch (settings.name) {
    case Routes.splash:
      return NoAnimationPageRoute(
        settings: RouteSettings(name: Routes.splash),
        builder: (context) => SplashScreen(),
      );

    case Routes.mainPage:
      return FadeTransitionPageRoute(
        settings: RouteSettings(name: Routes.mainPage),
        builder: (context) => ProgressHud(
          child: MainPage(),
        ),
      );

    default:
      return NoAnimationPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Không tìm thấy ${settings.name}'),
          ),
        ),
      );
  }
}