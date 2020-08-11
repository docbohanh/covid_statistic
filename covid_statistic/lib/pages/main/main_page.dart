import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_statistic/database/covid_data.dart';
import 'package:covid_statistic/generated/i18n.dart';
import 'package:covid_statistic/helper/app_bar.dart';
import 'package:covid_statistic/helper/color_loader.dart';
import 'package:covid_statistic/helper/hud.dart';
import 'package:covid_statistic/helper/locale_dropdown.dart';
import 'package:covid_statistic/helper/title_view.dart';
import 'package:covid_statistic/model/app_state.dart';
import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/country_info.dart';
import 'package:covid_statistic/model/main_info.dart';
import 'package:covid_statistic/model/prevention.dart';
import 'package:covid_statistic/network/response/response.dart';
import 'package:covid_statistic/pages/main/main_drop.dart';
import 'package:covid_statistic/pages/main/precautions/precaution_grid.dart';
import 'package:covid_statistic/pages/main/stats/pandemic_view.dart';
import 'package:covid_statistic/pages/main/top_country/country_stats.dart';
import 'package:covid_statistic/utils/themes/app_theme.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:covid_statistic/utils/local_utils.dart';
import 'package:covid_statistic/utils/utility.dart';
import 'package:covid_statistic/view_model/main_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin {
  AnimationController animationController;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  final viewModel = MainViewModel();

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 618), vsync: this);

    viewModel.mainInfoStream.listen((mainInfo) {
      if (viewModel.pandemicStats == null) {
        viewModel.fetchedStatistic(updateOther: true);
      } else {
        viewModel.updateMainInfoPandemic();
      }
    });

    getLocalCovidInfo();

    super.initState();

    viewModel.getCountryDisease();

    Future.delayed(Duration(milliseconds: 500))
        .then((value) => viewModel.refreshMainInfoPandemic());
  }

  void getLocalCovidInfo() async {
    await Future.delayed(Duration(milliseconds: 300));

    var data = await CovidLocalData.getCovidData();
    logger.info('Get local ${data.length} items');

    if (data.isNotEmpty) {
      var res = CovidStatsResponse(code: 1, data: data);

      viewModel.onRefreshStats(false);
      viewModel.statsResponse(res);

      viewModel.pandemicResponse(res.countryInfo(MainInfo.world));
    }

    viewModel.mainInfoChanged(MainInfo.world);
  }

  void refreshPandemicInfo() {
    logger.info('refreshPandemicInfo');
    viewModel.refreshMainInfoPandemic();
  }

  void addAllListData() {
    const int count = 6;

    listViews.add(
      StreamBuilder<MainInfo>(
        stream: viewModel.mainInfoStream,
        initialData: viewModel.mainInfoItem,
        builder: (context, AsyncSnapshot<MainInfo> snapshot) {
          return TitleView(
            title: MainDropdown(
              value: snapshot.data,
              onChanged: viewModel.mainInfoChanged,
            ),
            subTxt: S.of(context).details,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * 0, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: animationController,
            onViewMore: () {
              Utilities.launchURL(context, url: viewModel.mainInfoItem.link);
            },
          );
        },
      ),
    );

    listViews.add(
      StreamBuilder(
        stream: viewModel.pandemicInfo,
        builder: (context, AsyncSnapshot<CovidInfo> snapshot) {
          return PandemicView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * 1, 1.0,
                        curve: Curves.fastOutSlowIn))),
            info: (snapshot.data != null) ? snapshot.data : CovidInfo.mock48,
            onRefresh: () => refreshPandemicInfo(),
            viewModel: viewModel,
            onChartView: () {
//              HUD.showMessage(context, text: 'Show chart');
              showDialog(
                  context: context,
                  builder: (context) {
                    void dismiss() {
                      Navigator.of(context).pop();
                    }

                    return GestureDetector(
                      onTap: dismiss,
                      onVerticalDragDown: (_) => dismiss,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 128,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://ncov.moh.gov.vn/documents/20182/6848000/infographicVN1120.jpg',
                        ),
                      ),
                    );
                  });
            },
          );
        },
      ),
    );

    listViews.add(
      TitleView(
        title: GestureDetector(
          onTap: () => viewModel.getCountryDisease(),
          child: StreamBuilder(
            stream: viewModel.refreshCountryStream,
            initialData: false,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData || !snapshot.data) {
                return Text(
                  S.of(context).topInfectedCountries,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    letterSpacing: 0.5,
                    color: AppTheme.nearlyDarkBlue,
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
        subText: StreamBuilder(
          stream: viewModel.multiLangStream,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return Text(
              S.of(context).more,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                letterSpacing: 0.5,
                color: AppTheme.nearlyDarkBlue,
              ),
            );
          },
        ),
        onViewMore: () {
          HUD.showMessage(context, text: 'See more at https://disease.sh/v3');
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(StreamBuilder(
      stream: viewModel.countryPandemicStream,
      builder: (context, AsyncSnapshot<List<CountryPandemic>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return SizedBox();
        }
        return CountryStatsView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: animationController,
                  curve: Interval((1 / count) * 3, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: animationController,
          topCountriesData: snapshot.data,
          viewModel: viewModel,
        );
      },
    ));

    listViews.add(
      StreamBuilder(
        stream: viewModel.multiLangStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TitleView(
            title: Text(
              S.of(context).precautions,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                letterSpacing: 0.5,
                color: AppTheme.lightText,
              ),
            ),
            subTxt: S.of(context).more,
            onViewMore: () {
              HUD.showMessage(context, text: 'View more');
            },
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * 4, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: animationController,
          );
        },
      ),
    );

    listViews.add(
      StreamBuilder(
        stream: viewModel.multiLangStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return AreaListView(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * 5, 1.0,
                        curve: Curves.fastOutSlowIn))),
            animationController: animationController,
            preventions: [
              Prevention(
                  prevention: S.of(context).protectiveMask,
                  description: S.of(context).protectiveMaskDesc,
                  imagePath: 'assets/prevention/mask.png'),
              Prevention(
                  prevention: S.of(context).washHands,
                  description: S.of(context).washHandsDesc,
                  imagePath: 'assets/prevention/wash.png'),
              Prevention(
                  prevention: S.of(context).coverCough,
                  description: S.of(context).coverCoughDesc,
                  imagePath: 'assets/prevention/coughCover.png'),
              Prevention(
                  prevention: S.of(context).sanitizeOften,
                  description: S.of(context).sanitizeOftenDesc,
                  imagePath: 'assets/prevention/sanitizer.png'),
              Prevention(
                  prevention: S.of(context).noFaceTouching,
                  description: S.of(context).noFaceTouchingDesc,
                  imagePath: 'assets/prevention/touch.png'),
              Prevention(
                  prevention: S.of(context).socialDistancing,
                  description: S.of(context).socialDistancingDesc,
                  imagePath: 'assets/prevention/socialDistance.png'),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listViews.isEmpty) addAllListData();

    final language = AppStateProvider.of<AppState>(context).languageCode;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: gradientAppbar(
            title: S.of(context).appTitle,
            height: 54,
            actions: [
              LocaleDropDown(
                locale: LocalizationUtils.locale(language.value),
                onChanged: (String newValue) async {
                  language.value = newValue;
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setString(Constant.language, newValue);
                  viewModel.multiLangChanged(newValue);
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              getMainListViewUI(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return StreamBuilder(
      stream: viewModel.pandemicInfo,
      builder: (context, AsyncSnapshot<CovidInfo> snapshot) {
        if (!snapshot.hasData) {
          return ColorLoader();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 24 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
