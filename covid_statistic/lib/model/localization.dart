import 'package:flutter/material.dart';

abstract class ILocalization{
  final String name = null;
  final String languageCode = null;
  final String countryCode = null;

  Locale getLocale(){
    return Locale(languageCode,countryCode);
  }

  String get localeCode => "${languageCode.toLowerCase()}_${countryCode.toLowerCase()}";
}

class ENUSLocale extends ILocalization{
  @override
  String get countryCode => 'US';

  @override
  String get languageCode => 'en';

  @override
  String get name => 'United States';


}

class VIVNLocale extends ILocalization{
  @override
  String get countryCode => 'VN';

  @override
  String get languageCode => 'vi';

  @override
  String get name => 'Việt Nam';


}