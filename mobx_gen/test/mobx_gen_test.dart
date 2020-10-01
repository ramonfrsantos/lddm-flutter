import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_gen/mobx_gen.dart';

void main() {
  const MethodChannel channel = MethodChannel('mobx_gen');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MobxGen.platformVersion, '42');
  });
}
