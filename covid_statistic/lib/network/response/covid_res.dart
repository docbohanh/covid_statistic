import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/network/response/response.dart';

class CovidInfoResponse implements BaseResponse<CovidInfo> {
  @override
  int code;

  @override
  CovidInfo data;

  @override
  String message;

  CovidInfoResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = CovidInfo.fromJson(json['data']);
  }
}