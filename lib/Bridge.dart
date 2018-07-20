import 'package:flutter/services.dart';

class Bridge {
  static BasicMessageChannel channel = BasicMessageChannel("mainChannel", new StandardMessageCodec());

  void viewReady() {
    channel.send("ViewReady");
  }

  void dismiss() {
    channel.send("Dismiss");
  }
}