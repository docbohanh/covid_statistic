export 'remote_api.dart';
export 'mock_api.dart';

import 'package:covid_statistic/model/covid_info.dart';

enum ApiType { mock, remote }

abstract class API {
  ApiType apiType;

  Future<List<CovidInfo>> getWorldometersInfo();

  Future<CovidInfo> getPandemicWorld();

  Future<CovidInfo> getPandemicVN();
}
