import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_statistic/model/prevention.dart';
import 'package:covid_statistic/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AreaListView extends StatefulWidget {
  const AreaListView({
    Key key,
    this.animationController,
    this.animation,
    this.preventions,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<dynamic> animation;
  final List<Prevention> preventions;

  @override
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
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
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: GridView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(
                    widget.preventions.length,
                    (int index) {
                      final int count = widget.preventions.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return AreaView(
                        index: index,
                        animation: animation,
                        animationController: animationController,
                        precaution: widget.preventions[index],
                      );
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 0.75,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key key,
    this.index,
    this.animationController,
    this.animation,
    this.precaution,
  }) : super(key: key);

  final int index;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final Prevention precaution;

  static AutoSizeGroup titleGrp = AutoSizeGroup();
  static AutoSizeGroup descGrp = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.grey.withOpacity(0.1),
                      offset: Offset.zero,
                      blurRadius: 5.0),
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                elevation: 5,
                child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 650),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
//                  padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                  child: LayoutBuilder(
                    builder: (ctx, constraint) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Image(
                                image: AssetImage(precaution.imagePath),
                                height: constraint.maxHeight * 0.46,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              LimitedBox(
                                maxHeight: constraint.maxHeight * 0.1,
                                child: AutoSizeText(
                                  "${precaution.prevention}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  minFontSize: 11,
                                  stepGranularity: 1,
                                  group: titleGrp,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              LimitedBox(
                                maxHeight: constraint.maxHeight * 0.30,
                                child: AutoSizeText(
                                  "${precaution.description}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxFontSize: 12,
                                  minFontSize: 9,
                                  group: descGrp,
                                  stepGranularity: 1,
                                  maxLines: 4,
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
