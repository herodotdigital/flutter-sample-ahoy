import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class AhoyBarButton extends StatelessWidget {
  final Function onTap;
  final String imagePath;

  AhoyBarButton({Key key, @required this.imagePath, @required this.onTap}) : super(key: key);

  AhoyBarButton.close({Key key, @required Function onTap}) : this(imagePath: 'assets/images/close.png', onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(0.0),
      minSize: 24.0,
      child: _icon(imagePath),
      onPressed: onTap,
    );
  }

  Widget _icon(String imageName) {
    return Image(
      image:  AssetImage(imageName),
    );
  }
}

