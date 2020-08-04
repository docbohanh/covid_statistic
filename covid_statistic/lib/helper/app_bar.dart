import 'dart:io';

import 'package:covid_statistic/utils/app_theme.dart';
import 'package:covid_statistic/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';

import 'custom_circle.dart';

Widget gradientAppbar(
    {String title = '',
    Widget leading,
    List<Widget> actions,
    Widget bottom,
    double height = 130.0}) {

  String today() {
    var date = DateTime.now();
    return DateFormat('EEEE, dd/MM/yyyy').format(date);
  }

  var isIOS = Platform.isIOS;

  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: AppTheme.grey.withOpacity(0.2),
            offset: Offset(1.1, 1.1),
            blurRadius: 15.0),
      ]),
      child: GradientAppBar(
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomPaint(
              painter: CircleOne(),
            ),
            CustomPaint(
              painter: CircleTwo(),
            ),
          ],
        ),
        title: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Covid-19 Pandemic',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  '${today()}',
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        leading: leading,
        actions: actions,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
        ),
        bottom: (bottom != null)
            ? PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: bottom,
              )
            : null,
      ),
    ),
  );
}
