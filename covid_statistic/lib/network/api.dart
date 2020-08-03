export 'remote_api.dart';
export 'mock_api.dart';

enum ApiType { mock, remote }

abstract class API {
  ApiType apiType;

}
