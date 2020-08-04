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

  bool get isVN => name.contains('Vietnam');

  static List<MainInfo> items = [world, vietnam];
}
