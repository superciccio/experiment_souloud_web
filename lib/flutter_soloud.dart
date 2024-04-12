// import 'package:web/web.dart' as web;

import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/audio_source.dart';
import 'package:flutter_soloud/sound_hash.dart';
import 'package:flutter_soloud/bindings_player_web_ffi.dart' as module;
import 'package:flutter_soloud/enums.dart';

import 'flutter_soloud_platform_interface.dart';

class FlutterSoloud {
  Future<String?> getPlatformVersion() {
    return FlutterSoloudPlatform.instance.getPlatformVersion();
  }

  PlayerErrors init() {
    final ret = PlayerErrors.values[module.initEngine()];
    debugPrint('***************** INIT result: $ret');
    return ret;
  }

  bool isInited() {
    return module.isInited() == 1 ? true : false;
  }

  /// On web reading a local file is not possible. Use [loadMem] instead
  Future<AudioSource> loadFile(
    String path, {
    LoadMode mode = LoadMode.memory,
  }) async {
    final hashPtr = module.malloc(4); // 4 bytes for an int
    final pathPtr = module.malloc(path.length);
    final result = module.loadFile(
      pathPtr,
      mode == LoadMode.memory ? true : false,
      hashPtr,
    );

    /// "*" means unsigned int 32
    final hash = module.getValue(hashPtr, '*');
    module.free(hashPtr);
    module.free(pathPtr);

    return AudioSource(SoundHash(hash));
  }

  /// On web the audio file must be loaded in memory first and then passed
  /// as [bytes].
  /// Here the [path] is used only as a reference to compute its hash.
  Future<AudioSource> loadMem(String path, Uint8List bytes) async {
    final hashPtr = module.malloc(4); // 4 bytes for an int
    final bytesPtr = module.malloc(bytes.length);
    final pathPtr = module.malloc(path.length);
    for (var i = 0; i < bytes.length; i++) {
      module.setValue(bytesPtr + i, bytes[i], 'i8');
    }
    for (var i = 0; i < path.length; i++) {
      module.setValue(pathPtr + i, path.codeUnits[i], 'i8');
    }
    final result = module.loadMem(
      pathPtr,
      bytesPtr,
      bytes.length,
      hashPtr,
    );

    /// "*" means unsigned int 32
    final hash = module.getValue(hashPtr, '*');

    module.free(hashPtr);
    module.free(bytesPtr);
    module.free(pathPtr);
    debugPrint(
        '***************** LOADMEM result: $result  hashPtr: $hashPtr  hash: $hash');

    final ret = AudioSource(SoundHash(hash));
    return ret;
  }

  Future<AudioSource> loadWaveform() async {
    final hashPtr = module.malloc(4); // 4 bytes for an int
    final result = module.loadWaveform(0, true, 0.25, 1, hashPtr);

    /// "*" means unsigned int 32
    var hash = module.getValue(hashPtr, '*');
    debugPrint(
        '***************** WAVEFORM result: $result  hashPtr: $hashPtr  hash: $hash');
    module.free(hashPtr);
    return AudioSource(SoundHash(hash));
  }

  void play(int soundHash) {
    final handlePtr = module.malloc(4); // 4 bytes for an int
    final result =
        module.play(soundHash, 0.2, 0.0, false, true, 0.0, handlePtr);

    /// "*" means unsigned int 32
    final handle = module.getValue(handlePtr, '*');
    debugPrint('***************** PLAY soundHash: $soundHash  result: $result  '
        'handlePtr: $handlePtr  handle: $handle');
    module.free(handlePtr);
  }

  void dispose() {
    module.dispose();
  }
}
