class CountryPandemic {
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int critical;
  int affectedCountries;
  CountryInfo countryInfo;
  String name;

  CountryPandemic(
      {this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.critical,
        this.countryInfo,
        this.name,
        this.affectedCountries});

  CountryPandemic.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    recovered = json['recovered'];
    critical = json['critical'];
    name = json['country'];
    affectedCountries = json['affectedCountries'];
    countryInfo = CountryInfo.fromJson(Map<String, dynamic>.from(json['countryInfo']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['critical'] = this.critical;
    data['affectedCountries'] = this.affectedCountries;
    return data;
  }

  String get newCasesToday {
    if (todayCases == 0) return '';
    return '+$todayCases';
  }
}

class CountryInfo {
  int id;
//  double latitude, longitude;
  String iso2, iso3, flag;

  CountryInfo.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
//        latitude = double.tryParse(json['lat']),
//        longitude = double.tryParse(json['long']),
        iso2 = json['iso2'],
        iso3 = json['iso3'],
        flag = json['flag'];
}

/**
{
    "updated": 1596603490951,
    "country": "Afghanistan",
    "countryInfo": {
      "_id": 4,
      "iso2": "AF",
      "iso3": "AFG",
      "lat": 33,
      "long": 65,
      "flag": "https://disease.sh/assets/img/flags/af.png"
    },
    "cases": 36782,
    "todayCases": 0,
    "deaths": 1288,
    "todayDeaths": 0,
    "recovered": 25669,
    "todayRecovered": 0,
    "active": 9825,
    "critical": 31,
    "casesPerOneMillion": 943,
    "deathsPerOneMillion": 33,
    "tests": 89377,
    "testsPerOneMillion": 2291,
    "population": 39004644,
    "continent": "Asia",
    "oneCasePerPeople": 1060,
    "oneDeathPerPeople": 30283,
    "oneTestPerPeople": 436,
    "activePerOneMillion": 251.89,
    "recoveredPerOneMillion": 658.1,
    "criticalPerOneMillion": 0.79
}
 */