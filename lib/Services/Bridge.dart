import 'package:flutter/services.dart';

class Bridge {
  static const channel = const MethodChannel('methodChannel');

  void viewReady() async {
    try {
      channel.invokeMethod("ViewReady");
    } on PlatformException catch (e) {
      print("Error invoking method ViewReady: ${e.message}");
    }
  }

  void dismiss() async {
    try {
      channel.invokeMethod("Dismiss");
    } on PlatformException catch (e) {
      print("Error invoking method Dismiss: ${e.message}");
    }
  }
}