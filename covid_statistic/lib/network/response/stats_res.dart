import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/network/response/response.dart';

class CovidStatsResponse implements BaseResponse<List<CovidInfo>> {
  @override
  int code;

  @override
  List<CovidInfo> data;

  @override
  String message;

  CovidStatsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = List<Map<String, dynamic>>.from(json['data'])
        .map((e) => CovidInfo.fromJson(e))
        .toList();
  }

  static List<String> continents = [
    'North America',
    'South America',
    'Asia',
    'Europe',
    'Africa',
    'Oceania',
  ];

  static List<String> ignoresName = [
    'World',
    'Total:'
  ];

  List<CovidInfo> getInfectedCountries() {
    return data.where((item) {
      if (item.country.isEmpty) return false;
      var ignores = continents + ignoresName;
      return !ignores.contains(item.country);
    });
  }

  List<CovidInfo> topInfectedCountries({int number = 5}) {
    var infectedCountries = getInfectedCountries();
    infectedCountries.sort((lhs, rhs) {
      return lhs.totalCases.compareTo(rhs.totalCases);
    });
    return infectedCountries.take(number).toList();
  }
}
