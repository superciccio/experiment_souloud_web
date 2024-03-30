import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_soloud_method_channel.dart';

abstract class FlutterSoloudPlatform extends PlatformInterface {
  /// Constructs a FlutterSoloudPlatform.
  FlutterSoloudPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSoloudPlatform _instance = MethodChannelFlutterSoloud();

  /// The default instance of [FlutterSoloudPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSoloud].
  static FlutterSoloudPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSoloudPlatform] when
  /// they register themselves.
  static set instance(FlutterSoloudPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
