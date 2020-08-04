import 'package:covid_statistic/model/localization.dart';
import 'package:covid_statistic/utils/constant.dart';

class LocalizationUtils {
  const LocalizationUtils._();
  static ILocalization getLocale(String locale) {
    locale = locale != null ? locale.toLowerCase() : '';

    if (locale == null || locale.isEmpty) {
      return Constant.locales[Constant.defaultLocaleKey];
    }

    String lang = Constant.locales.keys.firstWhere(
            (key) => key.substring(0, 2) == locale.substring(0, 2),
        orElse: () => Constant.defaultLocaleKey);

    return Constant.locales[lang];
  }

  static List<String> getLocaleNamesPretty() {
    return Constant.locales.keys
        .map((name) => name.toUpperCase())
        .toList();
  }
}