import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lodash_flutter_method_channel.dart';

abstract class LodashFlutterPlatform extends PlatformInterface {
  /// Constructs a LodashFlutterPlatform.
  LodashFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static LodashFlutterPlatform _instance = MethodChannelLodashFlutter();

  /// The default instance of [LodashFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelLodashFlutter].
  static LodashFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LodashFlutterPlatform] when
  /// they register themselves.
  static set instance(LodashFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
