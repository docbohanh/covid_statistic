import 'package:covid_statistic/generated/i18n.dart';
import 'package:covid_statistic/router/router.dart';
import 'package:covid_statistic/utils/themes/app_theme.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frideos/frideos.dart';

import 'model/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(new App()));
}

class App extends StatelessWidget {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<AppState>(
      appState: appState,
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language = AppStateProvider.of<AppState>(context).languageCode;

    return ValueBuilder<String>(
      streamed: language,
      initialData: 'en',
      builder: (context, AsyncSnapshot<String> snapshot) => MaterialApp(
        title: 'Covid-19 Pandemic',
        theme: _buildThemeData(AppTheme.defaultLight),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: Locale(snapshot.data, ""),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: Routes.splash,
      ),
    );
  }

  ThemeData _buildThemeData(MyTheme appTheme) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: appTheme.textColor));

    return ThemeData(
      brightness: appTheme.brightness,
      backgroundColor: appTheme.backgroundColor,
      scaffoldBackgroundColor: appTheme.scaffoldBackgroundColor,
      primaryColor: appTheme.primaryColor,
      primaryColorBrightness: appTheme.primaryColorBrightness,
      accentColor: appTheme.accentColor,
      primaryColorLight: appTheme.primaryColorLight,
      primaryColorDark: appTheme.primaryColorDark,
    );
  }
}
