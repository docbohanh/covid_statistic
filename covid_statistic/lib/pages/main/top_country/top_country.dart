import 'package:covid_statistic/model/color_data.dart';
import 'package:covid_statistic/model/covid_info.dart';
import 'package:covid_statistic/view_model/main_vm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TopCountryView extends StatefulWidget {
  const TopCountryView({
    Key key,
    this.animationController,
    this.animation,
    this.topCountriesData,
    this.viewModel,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<dynamic> animation;
  final List<CovidInfo> topCountriesData;
  final MainViewModel viewModel;

  @override
  _TopCountryViewState createState() => _TopCountryViewState();
}

class _TopCountryViewState extends State<TopCountryView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<CovidInfo> topCountriesData = [];

  @override
  void initState() {
    topCountriesData = widget.topCountriesData.take(6).toList();
    _initAnimation();
    super.initState();

    widget.viewModel.refreshCountryStream.listen((isRefresh) {
      if (!isRefresh) {
        _initAnimation();
        topCountriesData = widget.viewModel.pandemicStats.topInfectedCountries();
        setState(() {});
        animationController.forward();
      }
    });
  }

  _initAnimation() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: topCountriesData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = topCountriesData.length > 10
                      ? 10
                      : topCountriesData.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return CountryPandemicView(
                    info: topCountriesData[index],
                    animation: animation,
                    animationController: animationController,
                    colorData: ItemColor.data[index % ItemColor.data.length],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class CountryPandemicView extends StatelessWidget {
  const CountryPandemicView({
    Key key,
    this.info,
    this.animationController,
    this.animation,
    this.colorData,
  }) : super(key: key);

  final CovidInfo info;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final ItemColor colorData;

  static final formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 150,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: colorData.endColor.withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            colorData.startColor,
                            colorData.endColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
//                            SizedBox(
//                              height: 30,
//                              width: 40,
//                              child: CachedNetworkImage(
//                                imageUrl: country.countryInfo.flag,
//                              ),
//                            ),
                            SizedBox(height: 5),
                            Text(
                              '${info.country}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                letterSpacing: 0.2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '${formatter.format((info.totalCases * animationController.value).toInt())}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                letterSpacing: 0.2,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(''),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              '${info.newCases}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Colors.amberAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
