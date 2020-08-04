import 'package:covid_statistic/model/localization.dart';

class AppConstant {
  AppConstant._();

  static const String isFirstLogin = 'is_first_login';

  static const String appTheme = 'app_theme';

  static const defaultLocaleKey=kENUS;
  static final locales = kLocales;
}

const kVIVN = "vi_vn";
const kENUS = "en_us";

final Map<String, ILocalization> kLocales = {
  kENUS: ENUSLocale(),
  kVIVN: VIVNLocale(),
};