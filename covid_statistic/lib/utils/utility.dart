import 'package:covid_statistic/helper/hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:url_launcher/url_launcher.dart';

final SimpleLogger logger = SimpleLogger()
  ..mode = LoggerMode.print
  ..setLevel(Level.FINEST, includeCallerInfo: true);

class Utilities {
  static launchURL(BuildContext context,
      {String url,
      String errorMessage = 'Đường dẫn không tồn tại',
      bool needShowDialog = true,
      Map<String, String> headers}) async {
    logger.info('Open url: $url');

    if (await canLaunch(url)) {
      await launch(
        url,
        enableJavaScript: true,
        enableDomStorage: true,
        headers: headers,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      if (needShowDialog) HUD.showMessage(context, text: errorMessage);
    }
  }

  static hideKeyboardOf(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Widget backBarButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget buildNeuWidget({
    Color baseColor,
    Widget child,
    LightSource source = LightSource.top,
    NeumorphicStyle style,
  }) {
    var myStyle = style;
    if (myStyle == null) {
      myStyle = NeumorphicStyle(
        depth: -1,
        oppositeShadowLightSource: true,
      );
    }

    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: baseColor ?? Color(0xFFFEFEFE),
        depth: 20,
        intensity: 0.9,
        lightSource: source,
      ),
      themeMode: ThemeMode.light,
      child: Neumorphic(
        margin: EdgeInsets.symmetric(horizontal: 4),
        style: myStyle,
        child: Neumorphic(
          style: myStyle,
          padding: EdgeInsets.all(2),
          child: child,
        ),
      ),
    );
  }

  static Future<bool> showConfirmDialog(
    BuildContext context, {
    String title = 'Xác nhận',
    String message = '',
    String okTitle = 'Đồng ý',
    String cancelTitle = 'Bỏ qua',
    bool showCancelButton = true,
    Function onPressedOK,
    Function onPressCancel,
  }) {
    var okAction = FlatButton(
      child: Text(
        okTitle,
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressedOK != null) {
          onPressedOK();
        }
      },
    );
    var cancelAction = FlatButton(
      child: Text(
        cancelTitle,
        style: TextStyle(color: Colors.blueGrey),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onPressCancel != null) {
          onPressCancel();
        }
      },
    );

    var actions = showCancelButton ? [cancelAction, okAction] : [okAction];

    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: GoogleFonts.merriweather(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              message,
              style: GoogleFonts.lato(
                fontSize: 15,
              ),
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
