export 'remote_api.dart';
export 'mock_api.dart';

import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/country_info.dart';
import 'package:covid_statistic/network/response/response.dart';

enum ApiType { mock, remote }

abstract class API {
  ApiType apiType;

  Future<CovidStatsResponse> getWorldometersInfo();

  Future<CovidInfo> getPandemicWorld();

  Future<CovidInfo> getPandemicVN();

  Future<List<CountryPandemic>> getCountryPandemic();
}
