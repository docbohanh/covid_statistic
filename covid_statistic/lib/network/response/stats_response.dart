import 'package:covid_statistic/model/covid_stats.dart';
import 'package:covid_statistic/network/response/response.dart';

class CovidStatsResponse implements BaseResponse<List<CovidStats>> {
  @override
  int code;

  @override
  List<CovidStats> data;

  @override
  String message;

  CovidStatsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = List<Map<String, dynamic>>.from(json['data'])
        .map((e) => CovidStats.fromJson(e))
        .toList();
  }
}
