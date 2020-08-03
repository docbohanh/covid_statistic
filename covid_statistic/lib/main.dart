import 'package:covid_statistic/router/router.dart';
import 'package:covid_statistic/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final theme = AppStateProvider.of<AppState>(context).currentTheme;

    return ValueBuilder<MyTheme>(
      streamed: theme,
      initialData: AppTheme.defaultLight,
      builder: (context, snapshot) => MaterialApp(
        title: 'Covid-19 Tracker',
        theme: _buildThemeData(snapshot.data),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: Routes.splash,
      ),
    );
  }

  ThemeData _buildThemeData(MyTheme appTheme) {
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
