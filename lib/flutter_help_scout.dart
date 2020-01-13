import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterHelpScout {
  static const MethodChannel _channel =
      const MethodChannel('flutter_help_scout');

  static Future<void> init(String beaconId,
      {bool clearAttributes = true, String title}) async {
    return await _channel.invokeMethod('init', <String, dynamic>{
      "id": beaconId,
      "clearAttributes": clearAttributes,
      "title": title,
    });
  }

  static Future<void> identify({
    @required String email,
    @required String name,
    Map<String, dynamic> attributes,
  }) async {
    return await _channel.invokeMethod('identify', <String, dynamic>{
      "email": email,
      "name": name,
      "attributes": attributes,
    });
  }

  static Future<void> open() async {
    return await _channel.invokeMethod('open');
  }

  static Future<void> logout() async {
    return await _channel.invokeMethod('logout');
  }
}
