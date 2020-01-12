import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_help_scout/flutter_help_scout.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_help_scout');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterHelpScout.platformVersion, '42');
  });
}
