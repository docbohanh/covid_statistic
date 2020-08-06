import 'package:covid_statistic/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting {
  String languageCode, themeName;

  Setting({this.languageCode, this.themeName}) {
    _init();
  }

  void _init() async {
    var prefs = await SharedPreferences.getInstance();

    // language
    final String language = prefs.getString(Constant.language);
    if (language != null) {
      var locale = supportedLocales.firstWhere(
            (lang) => lang.languageCode == language,
        orElse: () => supportedLocales[0],
      );

      languageCode = locale.languageCode;
    } else {
      languageCode = supportedLocales[0].languageCode;
    }

    // theme
    final String lastTheme = prefs.getString(Constant.appTheme);
    if (lastTheme != null) {
      themeName = kThemes[Constant.appTheme].name;
    } else {
      themeName = kThemes[0].name;
    }
  }

  void setLanguage({String languageCode}) async {
    this.languageCode = languageCode;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.language, languageCode);
  }

  void setTheme({String themeName}) async {
    this.themeName = themeName;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.appTheme, themeName);
  }
}