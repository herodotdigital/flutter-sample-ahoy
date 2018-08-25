import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DidAppear extends StatefulWidget {
  final Widget child;
  final Function onDidAppear;
  final int fadeInDuration;
  DidAppear({Key key, this.fadeInDuration = 700, @required this.onDidAppear, @required this.child}) : super(key:key);
  @override State<StatefulWidget> createState() => _DidAppearState();
}

class _DidAppearState extends State<DidAppear> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: widget.fadeInDuration), 
      vsync: this
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addStatusListener(_handleStatusUpdate);
    controller.forward();
    super.initState();
  }

  _handleStatusUpdate(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onDidAppear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }

}