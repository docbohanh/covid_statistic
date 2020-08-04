import 'package:covid_statistic/model/localization.dart';

import 'themes/theme.dart';

class Constant {
  Constant._();

  static const String isFirstLogin = 'is_first_login';

  static const String appTheme = 'app_theme';

  static const defaultLocaleKey=kENUS;
  static final locales = kLocales;

  static final themes = kThemes;
}

const kVIVN = "vi_vn";
const kENUS = "en_us";

final Map<String, ILocalization> kLocales = {
  kENUS: ENUSLocale(),
  kVIVN: VIVNLocale(),
};

const String kLightThemeKey = "light";
const String kDarkThemeKey = "dark";
const String kDraculaThemeKey = "dracula";

final Map<String, ITheme> kThemes = {
  kLightThemeKey: ThemeLight(),
  kDarkThemeKey: ThemeDark(),
  kDraculaThemeKey: ThemeDracula(),
};