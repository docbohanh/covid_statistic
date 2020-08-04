import 'package:flutter/material.dart';
import 'extra_palette.dart';

abstract class ITheme {
  ThemeData themeData;
  ExtraPalette extraPalette;

  ThemeData getThemeData();

  ExtraPalette getExtraPalette();

  ITheme initialize() {
    this.themeData = getThemeData();
    this.extraPalette = getExtraPalette();

    return this;
  }
}

/// DARK
class ThemeDark extends ITheme {
  @override
  ExtraPalette getExtraPalette() {
    return ExtraPalette(
        success: Color(0xff40CA87),
        error: Color(0xffFF5656),
        warning: Color(0xffDBC716),
        info: Colors.blue,
        light: Color(0xffEBE9E7),
        dark: Color(0xff231F1C));
  }

  @override
  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: Color(0xff393e3b),
      primaryColorLight: Color(0xff9C9F98),
      primaryColorDark: Color(0xff231F1C),
      accentColor: Color(0xffEBE9E7),
      canvasColor: Color(0xff393e3b),
      backgroundColor: Color(0xff231F1C),
      secondaryHeaderColor: Color(0xff2C2F26),
    );
  }
}

/// DRACULA
class ThemeDracula extends ITheme {
  @override
  ExtraPalette getExtraPalette() {
    return ExtraPalette(
      success: Color(0xff50D77B),
      error: Color(0xffff5555),
      warning: Color(0xffEDAB69),
      info: Color(0xff8be9fd),
      light: Color(0xfff8f8f2),
      dark: Color(0xff282a36),
    );
  }

  @override
  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: Color(0xff44475a),
      primaryColorLight: Color(0xffbd93f9),
      primaryColorDark: Color(0xff282a36),
      accentColor: Color(0xfff8f8f2),
      canvasColor: Color(0xff282a36),
      backgroundColor: Color(0xff282a36),
      errorColor: Color(0xffff5555),
      iconTheme: IconThemeData(color: Color(0xfff8f8f2)),
      primaryIconTheme: IconThemeData(color: Color(0xfff8f8f2)),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(color: Color(0xfff8f8f2)),
      buttonTheme: ButtonThemeData(buttonColor: Color(0xfff1fa8c)),
      buttonColor: Color(0xfff1fa8c),
      secondaryHeaderColor: Color(0xff44475a),
    );
  }
}

/// LIGHT
class ThemeLight extends ITheme {
  @override
  ExtraPalette getExtraPalette() {
    return ExtraPalette(
      success: Colors.green,
      error: Colors.red,
      warning: Colors.orange,
      info: Colors.blue,
      light: Color(0xffEBE9E7),
      dark: Color(0xff231F1C),
    );
  }

  @override
  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: Color(0xffdcddda),
      primaryColorLight: Color(0xff83867e),
      primaryColorDark: Color(0xffEBE9E7),
      accentColor: Color(0xff231F1C),
      backgroundColor: Color(0xffEBE9E7),
      buttonColor: Color(0xff231F1C),
      secondaryHeaderColor: Color(0xffcfd0cd),
    );
  }
}
