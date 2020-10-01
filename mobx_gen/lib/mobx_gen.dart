
import 'dart:async';

import 'package:flutter/services.dart';

class MobxGen {
  static const MethodChannel _channel =
      const MethodChannel('mobx_gen');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
