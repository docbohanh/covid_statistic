import 'package:covid_statistic/model/localization.dart';
import 'package:covid_statistic/utils/constant.dart';

class LocalizationUtils {
  const LocalizationUtils._();
  static ILocalization getLocale(String locale) {
    locale = locale != null ? locale.toLowerCase() : '';

    if (locale == null || locale.isEmpty) {
      return AppConstant.locales[AppConstant.defaultLocaleKey];
    }

    String lang = AppConstant.locales.keys.firstWhere(
            (key) => key.substring(0, 2) == locale.substring(0, 2),
        orElse: () => AppConstant.defaultLocaleKey);

    return AppConstant.locales[lang];
  }

  static List<String> getLocaleNamesPretty() {
    return AppConstant.locales.keys
        .map((name) => name.toUpperCase())
        .toList();
  }
}