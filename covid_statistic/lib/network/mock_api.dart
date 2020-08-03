import 'api.dart';

class MockAPI implements API {
  MockAPI._();

  static final shared = MockAPI._();

  @override
  ApiType apiType = ApiType.mock;
}