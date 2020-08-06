
import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/country_info.dart';
import 'package:covid_statistic/network/response/stats_res.dart';

import 'api.dart';

class MockAPI implements API {
  MockAPI._();

  static final shared = MockAPI._();

  @override
  ApiType apiType = ApiType.mock;

  @override
  Future<CovidInfo> getPandemicVN() {
    // TODO: implement getPandemicVN
    throw UnimplementedError();
  }

  @override
  Future<CovidInfo> getPandemicWorld() {
    // TODO: implement getPandemicWorld
    throw UnimplementedError();
  }

  @override
  Future<List<CountryPandemic>> getCountryDiseaseV3() {
    // TODO: implement getCountryPandemic
    throw UnimplementedError();
  }

  @override
  Future<CovidStatsResponse> getWorldometersInfo() {
    // TODO: implement getWorldometersInfo
    throw UnimplementedError();
  }
}