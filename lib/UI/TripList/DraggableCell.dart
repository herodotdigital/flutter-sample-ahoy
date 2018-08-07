import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';

class DraggableCell extends StatefulWidget {
  Widget child;
  Function onAccept;
  Function onDelete;

  DraggableCell({this.child, this.onAccept, this.onDelete});

  @override State<StatefulWidget> createState() => _DraggableCellState();
}

class _DraggableCellState extends State<DraggableCell> with SingleTickerProviderStateMixin {

  double xOffset = 0.0;
  double screenWidth = 320.0;
  Animation<double> animation;
  AnimationController controller;

  final double triggerThreshold = 106.0;
  final double borderRadius = 10.0;
  final cellMargin = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 9.0,
  );

  @override void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragCancel: _onDragCancel,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0, 
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child:_bottomLayer()
          ),
          _contentView()
        ],)
    );
  }

  _onDragUpdate(DragUpdateDetails details) {
    controller.reset();
    setState((){
      xOffset += details.delta.dx;
    });
  }

  _onDragEnd(DragEndDetails details) {
    if (_passedDragThreshold()) {
      if (xOffset.sign > 0) {
        widget.onAccept();
      } else {
        widget.onDelete();
      }
    }
    if (_passedDragThreshold()) {
      _playCompletionAnimation();
    } else {
      _playCancelAnimation();
    }
  }

  _onDragCancel() {
    setState((){
      _playCancelAnimation();
    });
  }

  Widget _contentView() {
    return Container(
        transform: Matrix4.translationValues(_currentXOffset(), 0.0, 0.0),
        margin: cellMargin,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: AhoyColors.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(4.5, 4.5)
            ),
          ],
        ),
        child: widget.child,
      );
  }

  double _currentXOffset() {
    double offset = xOffset;
    if (animation != null && animation.status == AnimationStatus.forward) {
      offset = animation.value;
    }
    return offset;
  }

  _playCancelAnimation() {
    _playAnimationTo(offset: 0.0);
  }

  _playCompletionAnimation() {
    final double offscreen = screenWidth * xOffset.sign;
    _playAnimationTo(offset: offscreen);
  }

  _playAnimationTo({@required double offset}) {
    controller.reset();
    final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: xOffset, end: offset).animate(curve);
    animation.addListener((){
      setState((){});
    });
    animation.addStatusListener((AnimationStatus status){
      if (status == AnimationStatus.completed) {
        xOffset = offset;
      }
    });
    controller.forward();
  }

  bool _passedDragThreshold() {
    return xOffset.abs() > triggerThreshold;
  }

  Widget _bottomLayer() {
    if (xOffset == 0.0) {
      return Container();
    } else if (xOffset.sign > 0) {
      return _acceptLayer();
    } else {
      return _dismissLayer();
    }
  }

  Widget _acceptLayer() {
    return _layer(
      text: "Approve",
      colors: [AhoyColors.approveColor, AhoyColors.approveDarkColor],
      image: 'assets/images/approveWhite.png',
      align: FractionalOffset.centerLeft,
    );
  }

  Widget _dismissLayer() {
    return _layer(
      text: "Dismiss",
      colors: [AhoyColors.declineDarkColor, AhoyColors.declineColor],
      image: 'assets/images/closeGrayWhite.png',
      align: FractionalOffset.centerRight,
    );
  }

  Widget _layer({@required String text, @required image, @required List<Color> colors, @required align}) {
    return 
      Container(
        margin: cellMargin,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.5),
        child: Container(
          alignment: align, 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(image, width: 24.0,),
              Container(height: 6.0, width: 1.0,),
              Text(text, style: AhoyStyles.list.bottomLayerStyle,),
            ],),
        ),
      );
  }
}