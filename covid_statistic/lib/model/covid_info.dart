class CovidInfo {
  String country, area, newCases, newDeaths;
  int totalCases, totalDeaths, totalRecovered, activeCases, seriousCritical;

  CovidInfo.fromJson(Map<String, dynamic> json)
      : country = json["country"],
        area = json["area"],
        newCases = json["newCases"],
        newDeaths = json["newDeaths"],
        totalCases = int.tryParse(json["totalCases"]),
        totalDeaths = int.tryParse(json["totalDeaths"]),
        totalRecovered = int.tryParse(json["totalRecovered"]),
        activeCases = int.tryParse(json["activeCases"]),
        seriousCritical = int.tryParse(json['seriousCritical']);

  int get newCasesValue {
    if (newCases.isEmpty) return 0;
    return int.tryParse(newCases.replaceAll('+', ''));
  }

  int get newDeathsValue {
    if (newDeaths.isEmpty) return 0;
    return int.tryParse(newDeaths.replaceAll('+', ''));
  }

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "totalCases": totalCases,
      "newCases": newCases,
      "totalDeaths": totalDeaths,
      "newDeaths": newDeaths,
      "totalRecovered": totalRecovered,
      "activeCases": activeCases,
      "seriousCritical": seriousCritical,
      "area": area
    };
  }

  static CovidInfo mock48 = CovidInfo.fromJson({
    "country": "Total:",
    "totalCases": "18444642",
    "newCases": "+9210",
    "totalDeaths": "697189",
    "newDeaths": "+366",
    "totalRecovered": "11675539",
    "activeCases": "6071914",
    "seriousCritical": "64677",
    "area": "All"
  });
}

/**
{
    "country": "Total:",
    "totalCases": "18444642",
    "newCases": "+9210",
    "totalDeaths": "697189",
    "newDeaths": "+366",
    "totalRecovered": "11675539",
    "activeCases": "6071914",
    "seriousCritical": "64677",
    "area": "All"
}
*/