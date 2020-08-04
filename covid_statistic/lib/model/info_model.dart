class InfoModel {
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int critical;
  int affectedCountries;

  InfoModel(
      {this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.critical,
        this.affectedCountries});

  InfoModel.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    recovered = json['recovered'];
    critical = json['critical'];
    affectedCountries = json['affectedCountries'];
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
}