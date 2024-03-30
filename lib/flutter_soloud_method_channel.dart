import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_soloud_platform_interface.dart';

/// An implementation of [FlutterSoloudPlatform] that uses method channels.
class MethodChannelFlutterSoloud extends FlutterSoloudPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_soloud');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
