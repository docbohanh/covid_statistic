export 'stats_response.dart';

class BaseResponse<T> {
  int code;

  /// Message from server
  String message;

  /// Json object
  T data;

  BaseResponse({this.code, this.message, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}