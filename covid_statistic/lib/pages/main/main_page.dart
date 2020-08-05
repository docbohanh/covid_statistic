import 'package:covid_statistic/helper/app_bar.dart';
import 'package:covid_statistic/helper/color_loader.dart';
import 'package:covid_statistic/helper/hud.dart';
import 'package:covid_statistic/helper/locale_dropdown.dart';
import 'package:covid_statistic/helper/title_view.dart';
import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/model/country_info.dart';
import 'package:covid_statistic/model/main_info.dart';
import 'package:covid_statistic/pages/main/main_drop.dart';
import 'package:covid_statistic/pages/main/precautions/precaution_grid.dart';
import 'package:covid_statistic/pages/main/stats/pandemic_view.dart';
import 'package:covid_statistic/pages/main/top_country/country_stats.dart';
import 'package:covid_statistic/utils/app_theme.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:covid_statistic/utils/local_utils.dart';
import 'package:covid_statistic/utils/utility.dart';
import 'package:covid_statistic/view_model/main_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    addAllListData();

    viewModel.mainInfoStream.listen((_) => refreshPandemicInfo());

    super.initState();

    viewModel.getCountryPandemic();

  }

  void refreshPandemicInfo() {
    logger.info('refreshPandemicInfo');
    if (viewModel.mainInfoItem.isVN) {
      viewModel.fetchedPandemicVN();
    } else {
      viewModel.fetchedPandemicWorld();
    }
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
            subTxt: 'Details',
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animationController,
                curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
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
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animationController,
                curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
            info: (snapshot.data != null) ? snapshot.data : CovidInfo.mock48,
            onRefresh: () => refreshPandemicInfo(),
            viewModel: viewModel,
            onChartView: () {
              HUD.showMessage(context, text: 'Show chart');
            },
          );
        },
      ),
    );

    listViews.add(
      TitleView(
        title: GestureDetector(
          onTap: () => viewModel.getCountryPandemic(),
          child: Text(
            'Top Infected Countries',
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              letterSpacing: 0.5,
              color: AppTheme.lightText,
            ),
          ),
        ),
        subTxt: 'More',
        onViewMore: () {
          HUD.showMessage(context, text: 'View more');
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
      StreamBuilder(
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
          );
        },
      )
    );

    listViews.add(
      TitleView(
        title: Text(
          'Precautions',
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            letterSpacing: 0.5,
            color: AppTheme.lightText,
          ),
        ),
        subTxt: 'More',
        onViewMore: () {
          HUD.showMessage(context, text: 'View more');
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );

    listViews.add(
      AreaListView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * 5, 1.0,
                    curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: gradientAppbar(height: 54, actions: [
            LocaleDropDown(
              locale: LocalizationUtils.getLocale(Constant.defaultLocaleKey),
              onChanged: (String newValue) {

              },
            )
          ]),
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
