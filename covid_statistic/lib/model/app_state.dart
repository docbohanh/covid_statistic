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
    _createThemes(themes);
    _createIcons();
  }

  static final AppState _singletonAppState = AppState._internal();

  // THEMES
  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();
  final currentIcons = StreamedValue<String>();
  final icons = List<String>();

  void _createIcons() {
    icons.addAll([
      'VTNB',
      'Quiz',
    ]);
  }

  void _createThemes(List<MyTheme> themes) {
    themes.addAll([
      AppTheme.defaultLight,
      AppTheme.defaultDark,
    ]);
  }

  void setTheme(MyTheme theme) async {
    currentTheme.value = theme;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.appTheme, theme.name);
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

  bool isPad;

  void setPhonePad(double shortestSide) {
    if (isPad == null) {
      logger.info('shortestSide = $shortestSide');
      isPad = shortestSide > 600;
    }
  }

  ///
  @override
  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();

    final String lastTheme = prefs.getString(AppConstant.appTheme);
    if (lastTheme != null) {
      currentTheme.value = themes.firstWhere(
            (theme) => theme.name == lastTheme,
        orElse: () => themes[0],
      );
    } else {
      currentTheme.value = themes[0];
    }

    final String lastIcon = prefs.getString('app_icon');
    if (lastIcon != null) {
      currentIcons.value = icons.firstWhere(
            (oldIcon) => oldIcon == lastIcon,
        orElse: () => icons[0],
      );
    } else {
      currentIcons.value = icons[0];
    }
  }

  @override
  void dispose() {
    logger.info('---------APP STATE DISPOSE-----------');
    currentTheme.dispose();
  }
}