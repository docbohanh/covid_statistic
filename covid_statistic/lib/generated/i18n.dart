import 'dart:async';

import 'package:covid_statistic/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
  GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appTitle => 'Covid-19 Pandemic';
  String get details => 'Details';
  String get totalCases => 'Total Cases';
  String get totalDeaths => 'Total Deaths';
  String get recovered => 'Recovered';
  String get newCases => 'New Cases';
  String get newDeaths => 'New Deaths';
  String get activeCases => 'Active Cases';
  String get more => 'More';
  String get topInfectedCountries => 'Top Infected Countries';
  String get precautions => 'Precautions';

  String get protectiveMask => 'Protective Mask';
  String get protectiveMaskDesc => 'Always remember to wear a protective mask when stepping out.';
  String get washHands => 'Wash Hands';
  String get washHandsDesc => 'Wash your hands often with soap and water and for 20 seconds at least.';
  String get coverCough => 'Cover Cough';
  String get coverCoughDesc => 'Cough or sneeze into your elbow or cover your mouth with a disposable napkin.';
  String get sanitizeOften => 'Sanitize Often';
  String get sanitizeOftenDesc => 'Use alchohol based sanitizer if water and soap are unavailable.';
  String get noFaceTouching => 'No Face Touching';
  String get noFaceTouchingDesc => 'Don\'t touch your eyes, nose or mouth often and with unwashed hands.';
  String get socialDistancing => 'Social Distancing';
  String get socialDistancingDesc => 'Keep 7m distance from other people. Stay at home and avoid gatherings.';
}

class $vi extends S {
  const $vi();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override String get appTitle => 'Đại dịch Covid-19';
  @override String get details => 'Chi tiết';
  @override String get totalCases => 'Số ca nhiễm';
  @override String get totalDeaths => 'Đã tử vong';
  @override String get recovered => 'Chữa khỏi';
  @override String get newCases => 'Mới nhiễm';
  @override String get newDeaths => 'Mới báo tử';
  @override String get activeCases => 'Đang điều trị';
  @override String get more => 'Xem thêm';
  @override String get topInfectedCountries => 'Quốc gia lây nhiễm cao';
  @override String get precautions => 'Biện pháp phòng ngừa';

  @override String get protectiveMask => 'Đeo khẩu trang';
  @override String get protectiveMaskDesc => 'Luôn luôn đẹo khẩu trang khi ra ngoài';
  @override String get washHands => 'Rửa tay';
  @override String get washHandsDesc => 'Rửa tay thường xuyên với xà bông ít nhất 20 giây';
  @override String get coverCough => 'Che miệng khi ho';
  @override String get coverCoughDesc => 'Dùng khuỷu tay hoặc giấy ăn dùng một lần để che miệng khi ho hoặc hắt hơi';
  @override String get sanitizeOften => 'Khử trùng';
  @override String get sanitizeOftenDesc => 'Sử dụng chất khử trùng có cồn nếu không có nước và xà phòng.';
  @override String get noFaceTouching => 'Tránh đưa tay lên mặt';
  @override String get noFaceTouchingDesc => 'Hạn chế đưa tay lên mắt, mũi và miệng.';
  @override String get socialDistancing => 'Giữ khoảng cách';
  @override String get socialDistancingDesc => 'Giữ khoảng cách 7m với mọi người. Nên ở nhà và tránh tụ tập.';
}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "vi":
          S.current = const $vi();
          return SynchronousFuture<S>(S.current);
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        default:
        // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
    ? null
    : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
