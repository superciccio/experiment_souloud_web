import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_soloud/flutter_soloud_platform_interface.dart';
import 'package:flutter_soloud/flutter_soloud_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSoloudPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSoloudPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSoloudPlatform initialPlatform = FlutterSoloudPlatform.instance;

  test('$MethodChannelFlutterSoloud is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSoloud>());
  });

  test('getPlatformVersion', () async {
    FlutterSoloud flutterSoloudPlugin = FlutterSoloud();
    MockFlutterSoloudPlatform fakePlatform = MockFlutterSoloudPlatform();
    FlutterSoloudPlatform.instance = fakePlatform;

    expect(await flutterSoloudPlugin.getPlatformVersion(), '42');
  });
}
