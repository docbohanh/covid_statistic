import 'dart:convert';
import 'dart:io';

import 'package:covid_statistic/model/covid_stats.dart';
import 'package:covid_statistic/network/response/stats_response.dart';
import 'package:covid_statistic/utils/utility.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class RemoteAPI implements API {
  RemoteAPI._();

  static final shared = RemoteAPI._();

  @override
  ApiType apiType = ApiType.remote;

  @override
  Future<List<CovidStats>> getWorldometersInfo({
    String endpoint = 'https://thanhladev.herokuapp.com/api/coronavirus',
  }) async {
    try {
      var res = await http
          .get(endpoint)
          .then((r) => CovidStatsResponse.fromJson(json.decode(r.body)));
      logger.info(res.data);
      return res.data;
    } on SocketException catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }
}
