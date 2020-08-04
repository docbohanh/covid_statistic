import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/network/response/response.dart';

class CovidStatsResponse implements BaseResponse<List<CovidInfo>> {
  @override
  int code;

  @override
  List<CovidInfo> data;

  @override
  String message;

  CovidStatsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = List<Map<String, dynamic>>.from(json['data'])
        .map((e) => CovidInfo.fromJson(e))
        .toList();
  }
}
