import 'dart:js_interop';

// import 'package:web/web.dart' as web;

import 'package:flutter/foundation.dart';

import 'flutter_soloud_platform_interface.dart';

@JS('Module._initEngine')
external int initEngine();

@JS('Module._isInited')
external int isInited();

@JS('Module._loadWaveform')
external int loadWaveform(
    int waveform, bool superWave, double scale, double detune, JSInt32Array hash);

@JS('Module._play')
external int play(int soundHash, double volume, double pan, bool paused,
    bool looping, double loopingStartAt, JSInt32Array handle);

@JS('Module._dispose')
external void dispose();

class FlutterSoloud {
  Future<String?> getPlatformVersion() {
    return FlutterSoloudPlatform.instance.getPlatformVersion();
  }

  void init() {
    var result = initEngine();
    debugPrint('***************** $result');

    JSInt32Array h = Int32List(1).toJS;
    result = loadWaveform(1, true, 0.25, 1, h);
    debugPrint('***************** $result  $h');
    result = loadWaveform(2, true, 0.25, 1, h);
    debugPrint('***************** $result  $h');

    // result = play(soundHash, volume, pan, paused, looping, loopingStartAt, handle)
    // debugPrint('***************** $result  $h');
    // var b = isInited() == 1 ? true : false;
    // debugPrint('***************** $b');

    dispose();
  }
}
