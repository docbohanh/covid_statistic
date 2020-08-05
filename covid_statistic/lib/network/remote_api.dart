import 'dart:convert';

import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/country_info.dart';
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
  Future<CovidStatsResponse> getWorldometersInfo({
    String endpoint = 'https://thanhladev.herokuapp.com/api/coronavirus',
  }) async {
    try {
      var res = await http
          .get(endpoint)
          .then((r) => CovidStatsResponse.fromJson(json.decode(r.body)));
      logger.info(res.data.length);
      return res;
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

  Future<CountryPandemic> getWorldInfo() async {
    try {
      var response = await http
          .get('https://disease.sh/v3/covid-19/countries')
          .then((r) => Map<String, dynamic>.from(json.decode(r.body)));

      CountryPandemic info = CountryPandemic.fromJson(response);

      return info;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }

  Future<CountryPandemic> getCountryInfo(String country) async {
    try {
      var response =
          await http.get("https://disease.sh/v3/covid-19/countries/$country");

      CountryPandemic info = CountryPandemic.fromJson(
          Map<String, dynamic>.from(json.decode(response.body)));

      return info;
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }

  @override
  Future<List<CountryPandemic>> getCountryPandemic() async {
    try {
      var res = await http
          .get("https://disease.sh/v3/covid-19/countries/")
          .then((r) => List<Map<String, dynamic>>.from(json.decode(r.body)));
      logger.info(res.length);
      return res.map((e) => CountryPandemic.fromJson(e)).toList();
    } catch (e) {
      logger.info("ERROR ${e.toString()}");
      throw e;
    }
  }
}
