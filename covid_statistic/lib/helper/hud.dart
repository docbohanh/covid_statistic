import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_loader.dart';

enum ProgressHudType { loading, success, error, progress, onlyText }

class ProgressHud extends StatefulWidget {
  /// the offsetY of hud view position from center, default is -50
  final double offsetY;
  final Widget child;

  static const Color darkSky = Color(0xFF01477f);
  static const Color notWhite = Color(0xFFF2F3F8);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);

  static ProgressHudState of(BuildContext context) {
//    return context.ancestorStateOfType(const TypeMatcher<ProgressHudState>());
    return context.findAncestorStateOfType<ProgressHudState>();
  }

  const ProgressHud({
    @required this.child,
    this.offsetY = -50,
    Key key,
  }) : super(key: key);

  @override
  ProgressHudState createState() => ProgressHudState();
}

class ProgressHudState extends State<ProgressHud>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;

  var _isVisible = false;
  var _text = "";
  var _opacity = 0.0;
  var _progressType = ProgressHudType.loading;
  var _progressValue = 0.0;

  @override
  void initState() {
    final duration = Duration(milliseconds: 200);
    _animation = AnimationController(duration: duration, vsync: this)
      ..addListener(() {
        setState(() {
          _opacity = _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _isVisible = false;
          });
        }
      });
    super.initState();
  }

  /// dismiss hud
  Future<Null> dismiss() async {
    _animation.reverse().whenComplete(() {
      return Future.value(true);
    });
  }

  /// show hud with type and text
  void show(ProgressHudType type, String text) {
    _animation.forward();
    setState(() {
      _isVisible = true;
      _text = text;
      _progressType = type;
    });
  }

  /// show loading with text
  void showLoading({String text = ''}) {
    this.show(ProgressHudType.loading, text);
  }

  /// update progress value and text when ProgressHudType = progress
  ///
  /// should call `show(ProgressHudType.progress, "Loading")` before use
  void updateProgress(double progress, String text) {
    setState(() {
      _progressValue = progress;
      _text = text;
    });
  }

  /// show hud and dismiss automatically
  Future showAndDismiss(ProgressHudType type, String text) async {
    show(type, text);
    var millisecond = max(500 + text.length * 200, 1000);
    var duration = Duration(milliseconds: millisecond);
    await Future.delayed(duration);
    dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Offstage(
            offstage: !_isVisible,
            child: Opacity(
              opacity: _opacity,
              child: GestureDetector(
                onTap: () {
                  if (_progressType == ProgressHudType.onlyText) {
                    dismiss();
                  }
                },
                child: _createHud(),
              ),
            ))
      ],
    );
  }

  Widget _createHud() {
    const double kIconSize = 44;
    switch (_progressType) {
      case ProgressHudType.loading:
        var sizeBox = SizedBox(
          width: kIconSize,
          height: kIconSize,
          child: ColorLoader(),
        );
        return _createHudView(child: sizeBox);
      case ProgressHudType.error:
        return _createHudView(
            child:
            Icon(Icons.close, color: ProgressHud.darkSky, size: kIconSize));
      case ProgressHudType.success:
        return _createHudView(
            child:
            Icon(Icons.check, color: ProgressHud.darkSky, size: kIconSize));
      case ProgressHudType.onlyText:
        return _createHudView();
      case ProgressHudType.progress:
        var progressWidget = CustomPaint(
          painter: CircleProgressBarPainter(progress: _progressValue),
          size: Size(kIconSize, kIconSize),
        );
        return _createHudView(child: progressWidget);
      default:
        throw Exception("not implementation");
    }
  }

  Widget _createHudView({Widget child}) {
    var childWidget = (child != null)
        ? Container(
      padding: EdgeInsets.all(5),
      child: child,
    )
        : SizedBox();

    var dimmingColor = (_progressType == ProgressHudType.onlyText)
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.5);

    return Stack(
      children: <Widget>[
        // do not response touch event
        IgnorePointer(
          ignoring: false,
          child: Container(
            color: dimmingColor,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: ProgressHud.nearlyWhite,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: ProgressHud.grey.withOpacity(0.4),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 3.0),
              ],
            ),
            constraints: BoxConstraints(minHeight: 50, minWidth: 50),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  childWidget,
                  Container(
                    padding: EdgeInsets.only(top: 1.5),
                    child: _text.length > 0
                        ? Text(
                      _text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        decoration: TextDecoration.none,
                        color: ProgressHud.darkSky,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final Color fillColor;

  const CircleProgressBarPainter({
    this.progress = 0,
    this.strokeWidth = 3,
    this.color = ProgressHud.darkGrey,
    this.fillColor = ProgressHud.darkSky,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = this.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final double diam = min(size.width, size.height);
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.5;
    final radius = diam / 2.0;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    paint.color = this.fillColor;
    // draw in center
    var rect = Rect.fromLTWH((size.width - diam) * 0.5, 0, diam, diam);
    canvas.drawArc(rect, -0.5 * pi, progress * 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HUD {
  static const platform = const MethodChannel('Flutter_App');
  static var shared = HUD._();

  HUD._() {
    platform.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'message':
        debugPrint(call.arguments);
        return new Future.value('');
    }
  }

  static void showLoading(BuildContext context, {String text = ''}) {
    ProgressHud.of(context).showLoading(text: text);
  }

  static void showMessage(BuildContext context, {String text = ''}) {
    ProgressHud.of(context).show(ProgressHudType.onlyText, text);
  }

  static void dismiss(BuildContext context) async {
    await ProgressHud.of(context).dismiss();
  }
}