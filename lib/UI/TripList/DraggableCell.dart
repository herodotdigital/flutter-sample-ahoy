import 'package:flutter/material.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';

class DraggableCell extends StatefulWidget {
  Widget child;
  Function onAccept;
  Function onDelete;

  DraggableCell({this.child, this.onAccept, this.onDelete});

  @override State<StatefulWidget> createState() => _DraggableCellState();
}

class _DraggableCellState extends State<DraggableCell> {

  double xOffset = 0.0;
  double screenWidth = 320.0;
  final double triggerThreshold = 106.0;
  final double borderRadius = 10.0;
  final cellMargin = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 9.0,
  );

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
    setState((){
      if (_passedDragThreshold()) {
        //animate this
        xOffset = screenWidth * xOffset.sign;
      } else {
        xOffset = 0.0;
      }
    });
  }

  _onDragCancel() {
    setState((){
      xOffset = 0.0;
    });
  }

  Widget _contentView() {
    return Container(
        transform: Matrix4.translationValues(xOffset, 0.0, 0.0),
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
        // height: 100.0,
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