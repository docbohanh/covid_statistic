import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color background = Color(0xFFF2F3F8);
  static const Color darkText = Color(0xFF253840);
  static const Color lightText = Color(0xFF4A6572);
  static const Color nearlyBlack = Color(0xFF213333);

  /// Light theme
  static const Color darkSky = Color(0xFF01477f);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color backgroundWhite = Color(0xFFF2F3F8);
  static const Color grey = Color(0xFF3A5160);
  static const Color subBlue = Color(0xFF00B6F0);

  static var defaultLight = MyTheme(
    name: 'LIGHT',
    describe: 'Sáng',
    icon: Icons.wb_sunny,
    brightness: Brightness.light,
    backgroundColor: nearlyWhite,
    scaffoldBackgroundColor: backgroundWhite,
    primarySwatch: nearlyWhite,
    primaryColor: backgroundWhite,
    primaryColorBrightness: Brightness.light,
    accentColor: darkSky,
    textColor: darkSky,
    subTextColor: grey,
    boxItemColor: nearlyWhite,
    appBarBackgroundColor: darkSky,
    appBarTextColor: whiteText,
    popupBackgroundColor: darkSky,
    primaryColorDark: darkSky,
    primaryColorLight: darkSky.withOpacity(0.85),
    dividerColor: grey.withOpacity(0.45),
  );

  /// Dark theme
  static const Color nearlyDark = Color(0xFF252a36);
  static const Color backgroundDark = Color(0xFF21242e);
  static const Color darkerText = Color(0xFF17262A);
  static const Color whiteText = Color(0xFFfefefe);
  static const Color subText = Color(0xFFBBBBBB);

  static var defaultDark = MyTheme(
    name: 'DARK',
    describe: 'Tối',
    icon: Icons.brightness_6,
    brightness: Brightness.dark,
    backgroundColor: nearlyDark,
    scaffoldBackgroundColor: backgroundDark,
    primarySwatch: nearlyDark,
    primaryColor: backgroundDark,
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.orange[400],
    textColor: whiteText,
    subTextColor: subText,
    boxItemColor: nearlyDark,
    appBarBackgroundColor: nearlyDark,
    appBarTextColor: whiteText,
    popupBackgroundColor: darkSky,
    primaryColorDark: backgroundDark,
    primaryColorLight: nearlyDark,
    dividerColor: grey.withOpacity(0.45),
  );
}


class MyTheme {
  MyTheme({
    this.name,
    this.describe,
    this.icon,
    this.primarySwatch,
    this.brightness,
    this.backgroundColor,
    this.scaffoldBackgroundColor,
    this.primaryColor,
    this.primaryColorDark,
    this.primaryColorLight,
    this.primaryColorBrightness,
    this.accentColor,
    this.textColor,
    this.subTextColor,
    this.boxItemColor,
    this.appBarBackgroundColor,
    this.appBarTextColor,
    this.popupBackgroundColor,
    this.dividerColor,
  });

  String name;
  String describe;
  IconData icon;
  Brightness brightness;
  Color backgroundColor;
  Color scaffoldBackgroundColor;
  Color primaryColor;
  Color primaryColorDark;
  Color primaryColorLight;
  Brightness primaryColorBrightness;
  Color accentColor;
  Color primarySwatch;
  Color appBarBackgroundColor;
  Color appBarTextColor;
  Color textColor;
  Color subTextColor;
  Color boxItemColor;
  Color popupBackgroundColor;
  Color dividerColor;

  TextStyle appbarTitle() {
    return GoogleFonts.openSans(
      fontWeight: FontWeight.w600,
      fontSize: 17,
      color: appBarTextColor,
//      shadows: <Shadow>[
//        Shadow(
//          blurRadius: 2.0,
//          color: textColor.withOpacity(0.2),
//          offset: Offset(1.0, 1.0),
//        ),
//      ],
    );
  }
}