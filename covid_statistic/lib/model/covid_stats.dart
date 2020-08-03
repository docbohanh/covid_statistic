class CovidStats {
  String country, area, newsCases, newDeaths;
  String totalCases, totalDeaths, totalRecovered, activeCases, seriousCritical;

  CovidStats.fromJson(Map<String, dynamic> json)
      : country = json["country"],
        area = json["area"],
        newsCases = json["newsCases"],
        newDeaths = json["newDeaths"],
        totalCases = json["totalCases"],
        totalDeaths = json["totalDeaths"],
        totalRecovered = json["totalRecovered"],
        activeCases = json["activeCases"],
        seriousCritical = json['seriousCritical'];
}

/**
{
  "country": "Vietnam",
  "totalCases": "621",
  "newsCases": "+1",
  "totalDeaths": "6",
  "newDeaths": "",
  "totalRecovered": "373",
  "activeCases": "242",
  "seriousCritical": "",
  "area": "Asia"
}
*/