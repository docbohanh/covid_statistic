
import 'package:covid_statistic/model/covid_stats.dart';

import 'api.dart';

class MockAPI implements API {
  MockAPI._();

  static final shared = MockAPI._();

  @override
  ApiType apiType = ApiType.mock;

  @override
  Future<List<CovidStats>> getWorldometersInfo() {
    return Future.value([]);
  }
}