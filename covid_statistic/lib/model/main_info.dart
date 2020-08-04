class MainInfo {
  String name, link;

  MainInfo({this.name, this.link});

  static MainInfo world = MainInfo(
    name: 'World',
    link: 'https://www.worldometers.info/coronavirus/',
  );

  static MainInfo vietnam = MainInfo(
    name: 'Vietnam',
    link: 'https://ncov.moh.gov.vn/',
  );

  static List<MainInfo> items = [world, vietnam];
}
