import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lodash_flutter_platform_interface.dart';

/// An implementation of [LodashFlutterPlatform] that uses method channels.
class MethodChannelLodashFlutter extends LodashFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lodash_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
