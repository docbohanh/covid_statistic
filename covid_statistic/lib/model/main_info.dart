class MainInfo {
  String name, link;

  MainInfo({this.name, this.link});

  static MainInfo world = MainInfo(
    name: 'World',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo usa = MainInfo(
    name: 'USA',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo brazil = MainInfo(
    name: 'Brazil',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo india = MainInfo(
    name: 'India',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo russia = MainInfo(
    name: 'Russia',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo southAfrica = MainInfo(
    name: 'South Africa',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo peru = MainInfo(
    name: 'Peru',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo mexico = MainInfo(
    name: 'Mexico',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo vietnam = MainInfo(
    name: 'Vietnam',
    link: 'https://ncov.moh.gov.vn/',
  );

  bool get isVN => name.contains('Vietnam');

  static List<MainInfo> items = [
    world,
    vietnam,
    usa,
    brazil,
    india,
    russia,
    southAfrica,
    peru,
    mexico
  ];
}
