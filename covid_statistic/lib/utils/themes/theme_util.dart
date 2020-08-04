import 'package:covid_statistic/utils/constant.dart';
import 'package:covid_statistic/utils/themes/theme.dart';

class ThemeUtils {
  const ThemeUtils._();

  static ITheme getTheme(String themeName) {
    ITheme themeInstance;
    themeName = (themeName != null) ? themeName.toLowerCase() : '';

    if(themeName == null){
      themeInstance = Constant.themes[kDarkThemeKey];

    }


    else if (Constant.themes.containsKey(themeName)) {
      themeInstance = Constant.themes[themeName];
    } else {
      themeInstance = Constant.themes[kDarkThemeKey];
    }
    return themeInstance.initialize();
  }

  static List<String> getThemeNamesPretty(){
    return Constant.themes.keys.map((name) => name.toUpperCase()).toList();
  }
}