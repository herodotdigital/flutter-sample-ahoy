import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';

class AhoySegmentData {
  final String text;
  final Function callback;
  AhoySegmentData({this.text, this.callback});
}

enum _AhoySegmentPosition {
  single, first, last, middle
}

class AhoySegmentedControl extends StatefulWidget {
  final List<AhoySegmentData> segments;
  AhoySegmentedControl({this.segments});
  @override State<StatefulWidget> createState() => _AhoySegmentedControlState();
}

class _AhoySegmentedControlState extends State<AhoySegmentedControl> {
  int selected = 0;
  final double borderRadius = 20.0;

  @override Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AhoyColors.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(children: _allSegments()),
    );
  }

  List<Widget> _allSegments() {
    return widget.segments.map((AhoySegmentData segment){
      bool isSelected = widget.segments[selected] == segment;
      _AhoySegmentPosition position = positionForData(segment);
      return _segment(data: segment, accented: isSelected, position: position);
    }).toList();
  }

  _AhoySegmentPosition positionForData(AhoySegmentData data) {
    int index = widget.segments.indexOf(data);
    int begin = 0;
    int end = widget.segments.length - 1;
    if (index == begin && index == end) {
      return _AhoySegmentPosition.single;
    } else if (index == begin) {
      return _AhoySegmentPosition.first;
    } else if (index == end) {
      return _AhoySegmentPosition.last;
    } else {
      return _AhoySegmentPosition.middle;
    }
  }

  Widget _segment({@required AhoySegmentData data, @required bool accented, _AhoySegmentPosition position}) {
    return Expanded(
      flex: 1, 
      child: CupertinoButton(
        padding: EdgeInsets.all(0.0),
        color: accented ? AhoyColors.accentColor : AhoyColors.backgroundColor,
        minSize: 40.0,
        borderRadius: _borderRadiusForPosition(position),
        onPressed: (){
          setState(() {
            selected = widget.segments.indexOf(data);
          });
          data.callback();
        },
        child: Text(data.text, style: AhoyStyles.list.segmentedControlStyle(accented: !accented),)
      ),
    );
  }

  BorderRadius _borderRadiusForPosition(_AhoySegmentPosition position) {
    final radius = Radius.circular(borderRadius);
    switch (position) {
      case _AhoySegmentPosition.single: return BorderRadius.all(radius);
      case _AhoySegmentPosition.first: return BorderRadius.horizontal(left: radius);
      case _AhoySegmentPosition.last: return BorderRadius.horizontal(right: radius);
      case _AhoySegmentPosition.middle: return BorderRadius.all(Radius.zero);
    }
  }
}