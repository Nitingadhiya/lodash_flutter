import 'package:flutter_test/flutter_test.dart';
import 'package:lodash_flutter/lodash_flutter.dart';
import 'package:lodash_flutter/lodash_flutter_platform_interface.dart';
import 'package:lodash_flutter/lodash_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLodashFlutterPlatform
    with MockPlatformInterfaceMixin
    implements LodashFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LodashFlutterPlatform initialPlatform = LodashFlutterPlatform.instance;

  test('$MethodChannelLodashFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLodashFlutter>());
  });

  test('getPlatformVersion', () async {
    LodashFlutter lodashFlutterPlugin = LodashFlutter();
    MockLodashFlutterPlatform fakePlatform = MockLodashFlutterPlatform();
    LodashFlutterPlatform.instance = fakePlatform;

    expect(await lodashFlutterPlugin.getPlatformVersion(), '42');
  });
}
