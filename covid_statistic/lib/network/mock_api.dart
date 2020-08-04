
import 'package:covid_statistic/model/covid_info.dart';

import 'api.dart';

class MockAPI implements API {
  MockAPI._();

  static final shared = MockAPI._();

  @override
  ApiType apiType = ApiType.mock;

  @override
  Future<List<CovidInfo>> getWorldometersInfo() {
    return Future.value([]);
  }

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
}