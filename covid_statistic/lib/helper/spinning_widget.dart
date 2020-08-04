import 'package:flutter/material.dart';

class SpinningWidget extends StatefulWidget {
  final double size;
  final Widget child;

  const SpinningWidget({
    Key key,
    @required this.size,
    this.child,
  }) : super(key: key);

  @override
  _SpinningWidgetState createState() => _SpinningWidgetState();
}

class _SpinningWidgetState extends State<SpinningWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 300));
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: widget.child,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
              offset: Offset(1.0, 1.0),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white70,
              offset: Offset(-1.0, -1.0),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
//          gradient: LinearGradient(
//            begin: Alignment.topLeft,
//            end: Alignment.bottomRight,
//            colors: [
//              Colors.grey[100],
//              Colors.grey[200],
//              Colors.grey[300],
//              Colors.grey[300],
//            ],
//            stops: [0.1, 0.3, 0.8, 1],
//          ),
        ),
      ),
    );
  }
}
