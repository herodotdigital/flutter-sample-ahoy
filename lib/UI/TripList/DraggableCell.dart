import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';
import 'package:meta/meta.dart';

/// Cell that can slide left or right.
/// onAccept - filling this callback enables cell to slide right with "accept color" background
/// onDecline - filling this callback enables cell to slide left with "decline color" background
/// onSlide - filling this callback enables cell to slide both sides with "accent color" background. Applies only when accept/decline directions are null.
class DraggableCell extends StatefulWidget {
  final Widget child;
  final Function onAccept;
  final Function onDecline;
  final Function onSlide;

  DraggableCell({Key key, this.child, this.onAccept, this.onDecline, this.onSlide}):super(key: key);

  @override State<StatefulWidget> createState() => DraggableCellState();

}

class DraggableCellState extends State<DraggableCell> with SingleTickerProviderStateMixin {

  double contentXOffset;
  double screenWidth;
  bool backgroundVisible;
  Animation<double> contentMoveAnimation;
  Animation<double> backgroundMoveAnimation;
  AnimationController controller;

  final double animationLength = 800.0;
  final double contentAnimationLength = 500.0;
  final double backgroundAnimationLength = 500.0;
  final Curve contentAnimationCurve = Curves.easeIn;
  final Curve backgroundAnimationCurve = Curves.easeIn;

  final double triggerThreshold = 106.0;
  final double borderRadius = 10.0;
  final cellMargin = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 9.0,
  );

  @override void initState() {
    contentXOffset = 0.0;
    screenWidth = 320.0;
    backgroundVisible = true;
    controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    super.initState();
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
    if (!_allowDrag(details)) {
      return;
    }
    controller.reset();
    setState((){
      contentXOffset += details.delta.dx;
    });
  }

  _onDragEnd(DragEndDetails details) {
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

  bool _allowDrag(DragUpdateDetails details) {
    bool acceptPossible = widget.onAccept != null;
    bool declinePossible = widget.onDecline != null;
    bool genericSlidePossible = widget.onSlide != null;
    bool dragRight = details.delta.dx > 0;
    bool dragLeft = details.delta.dx < 0;
    return genericSlidePossible || (dragRight && acceptPossible) || (dragLeft && declinePossible);
  }

  Widget _contentView() {
    return Container(
        transform: Matrix4.translationValues(_currentContentXOffset(), 0.0, 0.0),
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

  double _currentContentXOffset() {
    double offset = contentXOffset;
    if (contentMoveAnimation != null && contentMoveAnimation.status == AnimationStatus.forward) {
      offset = contentMoveAnimation.value;
    }
    return offset;
  }

  _playCancelAnimation() {
    _playAnimationTo(contentOffset: 0.0, animateBackground: false);
  }

  _playCompletionAnimation() {
    final double offscreen = screenWidth * contentXOffset.sign;
    _playAnimationTo(contentOffset: offscreen, animateBackground: true);
  }

  _playAnimationTo({@required double contentOffset, @required bool animateBackground}) {
    controller.reset();
    final Animation curve = CurvedAnimation(parent: controller, curve: Interval(0.0, contentAnimationLength/animationLength, curve: contentAnimationCurve));
    contentMoveAnimation = Tween(begin: contentXOffset, end: contentOffset).animate(curve);
    contentMoveAnimation.addListener((){
      setState((){});
    });
    contentMoveAnimation.addStatusListener((AnimationStatus status){
      if (status == AnimationStatus.completed) {
        setState(() {
          contentXOffset = contentOffset;
        });
      }
    });
    if (animateBackground) {
      final Animation delayed = CurvedAnimation(parent: controller, curve: Interval((animationLength-backgroundAnimationLength)/animationLength, animationLength/animationLength, curve: backgroundAnimationCurve));
      backgroundMoveAnimation = Tween(begin: 0.0, end: contentOffset).animate(delayed);
      backgroundMoveAnimation.addListener((){
        setState((){});
      });
      backgroundMoveAnimation.addStatusListener((AnimationStatus status){
        if (status == AnimationStatus.completed) {
          _runCompletionFor(offset: contentOffset);
          setState(() {
            backgroundVisible = false;          
          });
        }
      });
    }
    controller.forward();
  }

  _runCompletionFor({@required double offset}) {
    if (widget.onAccept != null && offset.sign > 0) {
      widget.onAccept();
    } else if (widget.onDecline != null && offset.sign < 0) {
      widget.onDecline();
    } else if (widget.onSlide != null) {
      widget.onSlide();
    }
  }

  bool _passedDragThreshold() {
    return contentXOffset.abs() > triggerThreshold;
  }

  bool get renderAcceptLayerNow => contentXOffset.sign > 0 && widget.onAccept != null;
  bool get renderDeclineLayerNow => contentXOffset.sign < 0 && widget.onDecline != null;
  bool get renderGenericSlideLayerNow => contentXOffset.sign != 0.0 && widget.onSlide != null;

  Widget _bottomLayer() {
    Widget layer;
    if (contentXOffset == 0.0 || !backgroundVisible) {
      return Container();
    } else if (renderAcceptLayerNow) {
      layer = _acceptLayer();
    } else if (renderDeclineLayerNow) {
      layer = _dismissLayer();
    } else if (renderGenericSlideLayerNow) {
      layer = _genericSlideLayer();
    } else {
      return Container();
    }
    double xTranslation = 0.0;
    if (backgroundMoveAnimation != null && backgroundMoveAnimation.status == AnimationStatus.forward) {
      xTranslation = backgroundMoveAnimation.value;
    }
    return Container(
      transform: Matrix4.translationValues(xTranslation, 0.0, 0.0),
      child: layer,
    );
  }

  Widget _genericSlideLayer() {
    const unusedAlignment = FractionalOffset.centerLeft;
    return _layer(colors: [AhoyColors.accentColor, AhoyColors.darkAccentColor], align: unusedAlignment);
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

  Widget _layer({String text, String image, @required List<Color> colors, @required align}) {
    List<Widget> innerColumn = [];
    if (image != null) {
      innerColumn.add(Image.asset(image, width: 24.0,));
    }
    if (image != null && text != null) {
      innerColumn.add(Container(height: 6.0, width: 1.0,));
    }
    if (text != null) {
      innerColumn.add(Text(text, style: AhoyStyles.list.bottomLayerStyle,));
    }
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
            children: innerColumn,
          ),
        ),
      );
  }
}