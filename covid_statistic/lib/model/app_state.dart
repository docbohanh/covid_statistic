import 'package:covid_statistic/network/api.dart';
import 'package:covid_statistic/utils/app_theme.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:covid_statistic/utils/utility.dart';
import 'package:frideos/frideos.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ApiType { mock, remote }

class AppState extends AppStateModel {
  factory AppState() => _singletonAppState;

  AppState._internal() {
    logger.info('-------APP STATE INIT--------');
    _createThemes();
  }

  static final AppState _singletonAppState = AppState._internal();

  // THEMES
  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();
  final languageCode = StreamedValue<String>();
  final currentIcons = StreamedValue<String>();
  final icons = List<String>();

  void _createThemes() {
    themes.addAll([
      AppTheme.defaultLight,
      AppTheme.defaultDark,
    ]);
  }

  void setTheme(MyTheme theme) async {
    currentTheme.value = theme;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.appTheme, theme.name);
  }

  void setIcons(String iconName) async {
    currentIcons.value = iconName;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('app_icon', iconName);
  }

  // API
  API api = MockAPI.shared;
  final apiType = StreamedValue<ApiType>(initialData: ApiType.mock);

  void setApiType(ApiType type) {
    if (apiType.value != type) {
      logger.info('Update api');
      apiType.value = type;
      if (type == ApiType.mock) {
        api = MockAPI.shared;
      } else {
        api = RemoteAPI.shared;
      }
      logger.info('type ${apiType.value} | api ${api.apiType}');
    }
  }

  ///
  @override
  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();

    final String lastTheme = prefs.getString(Constant.appTheme);
    if (lastTheme != null) {
      currentTheme.value = themes.firstWhere(
        (theme) => theme.name == lastTheme,
        orElse: () => themes[0],
      );
    } else {
      currentTheme.value = themes[0];
    }

    final String language = prefs.getString(Constant.language);
    if (language != null) {
      var locale = supportedLocales.firstWhere(
        (lang) => lang.languageCode == language,
        orElse: () => supportedLocales[0],
      );

      languageCode.value = locale.languageCode;
    } else {
      languageCode.value = supportedLocales[0].languageCode;
    }
  }

  @override
  void dispose() {
    logger.info('---------APP STATE DISPOSE-----------');
    currentTheme.dispose();
  }
}
