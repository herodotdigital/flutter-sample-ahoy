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

  @override Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragCancel: _onDragCancel,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Container(
        transform: Matrix4.translationValues(xOffset, 0.0, 0.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 9.0,
        ),
        padding: EdgeInsets.all(14.0),
        decoration: new BoxDecoration(
          color: AhoyColors.backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(4.5, 4.5)
            ),
          ],
        ),
        child: widget.child,
      )
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

  bool _passedDragThreshold() {
    return xOffset.abs() > triggerThreshold;
  }
}