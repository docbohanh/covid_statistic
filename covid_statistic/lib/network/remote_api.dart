import 'dart:convert';

import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/info_model.dart';
import 'package:covid_statistic/network/response/response.dart';
import 'package:covid_statistic/utils/utility.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class RemoteAPI implements API {
  RemoteAPI._();

  static final shared = RemoteAPI._();

  @override
  ApiType apiType = ApiType.remote;

  @override
  Future<List<CovidInfo>> getWorldometersInfo({
    String endpoint = 'https://thanhladev.herokuapp.com/api/coronavirus',
  }) async {
    try {
      var res = await http
          .get(endpoint)
          .then((r) => CovidStatsResponse.fromJson(json.decode(r.body)));
      logger.info(res.data);
      return res.data;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }

  @override
  Future<CovidInfo> getPandemicVN({
    String endpoint = 'https://thanhladev.herokuapp.com/api/covid19vn',
  }) async {
    try {
      var res = await http
          .get(endpoint)
          .then((r) => CovidInfoResponse.fromJson(json.decode(r.body)));
      logger.info(res.data.toJson());
      return res.data;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }

  @override
  Future<CovidInfo> getPandemicWorld({
    String endpoint = 'https://thanhladev.herokuapp.com/api/covid19',
  }) async {
    try {
      var res = await http
          .get(endpoint)
          .then((r) => CovidInfoResponse.fromJson(json.decode(r.body)));
      logger.info(res.data.toJson());
      return res.data;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }

  Future<InfoModel> getWorldInfo() async {
    try {
      var response = await http
          .get('https://disease.sh/v2/all')
          .then((r) => Map<String, dynamic>.from(json.decode(r.body)));

      InfoModel info = InfoModel.fromJson(response);

      return info;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }

  Future<InfoModel> getCountryInfo(String country) async {
    try {
      var response = await http.get("https://disease.sh/v2/countries/$country");

      InfoModel info = InfoModel.fromJson(
          Map<String, dynamic>.from(json.decode(response.body)));

      return info;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }
}
