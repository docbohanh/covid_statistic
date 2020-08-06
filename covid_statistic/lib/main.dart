import 'package:covid_statistic/generated/i18n.dart';
import 'package:covid_statistic/provider/language_provider.dart';
import 'package:covid_statistic/provider/theme_provider.dart';
import 'package:covid_statistic/router/router.dart';
import 'package:covid_statistic/utils/themes/app_theme.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frideos/frideos.dart';
import 'package:provider/provider.dart';

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
      builder: (context, snapshot) => MaterialApp(
        title: 'Covid-19 Pandemic',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: Locale(language.value, ""),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: Routes.splash,
      ),
    );
  }
}
