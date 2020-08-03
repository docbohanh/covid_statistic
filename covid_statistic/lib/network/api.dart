export 'remote_api.dart';
export 'mock_api.dart';

import 'package:covid_statistic/model/covid_stats.dart';

enum ApiType { mock, remote }

abstract class API {
  ApiType apiType;

  Future<List<CovidStats>> getWorldometersInfo();
}
