import 'package:covid_statistic/database/database.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CovidInfo {
  String country, area, newCases, newDeaths;
  int totalCases, totalDeaths, totalRecovered, activeCases, seriousCritical;

  CovidInfo.fromJson(Map<String, dynamic> json)
      : country = json["country"],
        area = json["area"],
        newCases = json["newCases"],
        newDeaths = json["newDeaths"],
        totalCases = int.tryParse(json["totalCases"]),
        totalDeaths = int.tryParse(json["totalDeaths"]),
        totalRecovered = int.tryParse(json["totalRecovered"]),
        activeCases = int.tryParse(json["activeCases"]),
        seriousCritical = int.tryParse(json['seriousCritical']);

  int get newCasesValue {
    if (newCases.isEmpty) return 0;
    return int.tryParse(newCases.replaceAll('+', ''));
  }

  int get newDeathsValue {
    if (newDeaths.isEmpty) return 0;
    return int.tryParse(newDeaths.replaceAll('+', ''));
  }

  double get angle {
    return 360 * totalRecovered / totalCases;
  }

  Widget get flag {
    var uCountry = COUNTRIES.where((element) {
      return country.toLowerCase().contains(element['name'].toLowerCase());
    }).first;

    if (uCountry == null) {
      return Container();
    }

    return SvgPicture.asset(
      "assets/flags/${uCountry['iso2'].toLowerCase()}.svg",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "totalCases": totalCases,
      "newCases": newCases,
      "totalDeaths": totalDeaths,
      "newDeaths": newDeaths,
      "totalRecovered": totalRecovered,
      "activeCases": activeCases,
      "seriousCritical": seriousCritical,
      "area": area,
    };
  }

  static CovidInfo mock48 = CovidInfo.fromJson({
    "country": "USA",
    "totalCases": "4862513",
    "newCases": "+339",
    "totalDeaths": "158968",
    "newDeaths": "+39",
    "totalRecovered": "2448295",
    "activeCases": "2255250",
    "seriousCritical": "18725",
    "area": "North America"
  });
}