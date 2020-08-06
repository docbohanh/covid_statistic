import 'package:covid_statistic/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String code;

  LanguageProvider() {
    _init();
  }

  void _init() async {
    var prefs = await SharedPreferences.getInstance();

    final String language = prefs.getString(Constant.language);
    if (language != null) {
      var locale = supportedLocales.firstWhere(
            (lang) => lang.languageCode == language,
        orElse: () => supportedLocales[0],
      );

      code = locale.languageCode;
    } else {
      code = supportedLocales[0].languageCode;
    }
  }

  void setLanguage({String languageCode}) async {
    code = languageCode;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.language, languageCode);
    notifyListeners();
  }
}