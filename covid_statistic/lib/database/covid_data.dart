import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/utils/utility.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class CovidLocalData {
  static Future<List<CovidInfo>> getCovidData(
      {int offset = 0, int limit = 20}) async {
    final db = await DatabaseProvider.dbProvider.database;

    List<Map<String, dynamic>> result =
        await db.query(covidTABLE, offset: offset, limit: limit);

    final List<CovidInfo> covidData = result.isNotEmpty
        ? result.map((c) => CovidInfo.fromJson(c)).toList()
        : [];
    logger.info('Get local ${covidData.length} items');
    return covidData;
  }

  static void initMockUpData() async {
    List<Map<String, dynamic>> mockData = [
      {
        "country": "World",
        "totalCases": "20016521",
        "newCases": "+219572",
        "totalDeaths": "733607",
        "newDeaths": "+4798",
        "totalRecovered": "12892084",
        "activeCases": "6390830",
        "seriousCritical": "64937",
        "area": "All"
      },
      {
        "country": "USA",
        "totalCases": "5199431",
        "newCases": "+47836",
        "totalDeaths": "165617",
        "newDeaths": "+534",
        "totalRecovered": "2664618",
        "activeCases": "2369196",
        "seriousCritical": "17897",
        "area": "North America"
      },
      {
        "country": "Brazil",
        "totalCases": "3035582",
        "newCases": "+22213",
        "totalDeaths": "101136",
        "newDeaths": "+593",
        "totalRecovered": "2118460",
        "activeCases": "815986",
        "seriousCritical": "8318",
        "area": "South America"
      },
      {
        "country": "India",
        "totalCases": "2214137",
        "newCases": "+62117",
        "totalDeaths": "44466",
        "newDeaths": "+1013",
        "totalRecovered": "1534278",
        "activeCases": "635393",
        "seriousCritical": "8944",
        "area": "Asia"
      },
      {
        "country": "Russia",
        "totalCases": "887536",
        "newCases": "+5189",
        "totalDeaths": "14931",
        "newDeaths": "+77",
        "totalRecovered": "693422",
        "activeCases": "179183",
        "seriousCritical": "2300",
        "area": "Europe"
      },
      {
        "country": "South Africa",
        "totalCases": "559859",
        "newCases": "+6671",
        "totalDeaths": "10408",
        "newDeaths": "+198",
        "totalRecovered": "411474",
        "activeCases": "137977",
        "seriousCritical": "539",
        "area": "Africa"
      },
      {
        "country": "Peru",
        "totalCases": "478024",
        "newCases": "+7012",
        "totalDeaths": "21072",
        "newDeaths": "+228",
        "totalRecovered": "324020",
        "activeCases": "132932",
        "seriousCritical": "1488",
        "area": "South America"
      },
      {
        "country": "Mexico",
        "totalCases": "475902",
        "newCases": "+6495",
        "totalDeaths": "52006",
        "newDeaths": "+695",
        "totalRecovered": "318638",
        "activeCases": "105258",
        "seriousCritical": "3892",
        "area": "North America"
      }
    ];

    final db = await DatabaseProvider.dbProvider.database;
    mockData.forEach((element) {
      db.insert(
        covidTABLE,
        element,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  static void insertCovidMainData(List<CovidInfo> data) async {
    final db = await DatabaseProvider.dbProvider.database;
    data.forEach((element) {
      db.insert(
        covidTABLE,
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }
}
