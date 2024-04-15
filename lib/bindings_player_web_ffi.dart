import 'dart:typed_data';
import 'dart:js_interop';

import 'package:flutter_soloud/enums.dart';

/// https://kapadia.github.io/emscripten/2013/09/13/emscripten-pointers-and-pointers.html
/// https://emscripten.org/docs/porting/connecting_cpp_and_javascript/Interacting-with-code.html#access-memory-from-javascript

/// https://github.com/isar/isar/blob/main/packages/isar/lib/src/web/web.dart
/// chromium --disable-web-security --disable-gpu --user-data-dir=~/chromeTemp

/// These exports should take place of "bindings_player_ffi.dart" and referenced
/// into SoLoudController taking the place of "soLoudFFI".
/// SoLoudController should be an `abstract` class which will conditional
/// import the appropriate bindings: the current SoLoudController for all
/// but web, and this for web.
///
/// AudioIsolate should use an abstract class for Isolate, SendPort, 
/// ReceivePort, Isolate.spawn, Isolate.kill
/// be rewritten using web.Worker
///
///

@JS('Module._malloc')
external int _malloc(int bytesCount);

@JS('Module._free')
external void _free(int ptrAddress);

@JS('Module.getValue')
external int _getValue(int ptrAddress, String type);

@JS('Module.setValue')
external void _setValue(int ptrAddress, int value, String type);

@JS('Module.cwrap')
external JSFunction _cwrap(
  JSString fName,
  JSString returnType,
  JSArray<JSString> argTypes,
);

@JS('Module.ccall')
external JSFunction _ccall(
  JSString fName,
  JSString returnType,
  JSArray<JSString> argTypes,
  JSArray<JSAny> args,
);

@JS('Module._initEngine')
external int _initEngine();

@JS('Module._dispose')
external void _dispose();

@JS('Module._isInited')
external int _isInited();

@JS('Module._loadFile')
external int _loadFile(int completeFileNamePtr, bool loadIntoMem, int hashPtr);

@JS('Module._loadMem')
external int _loadMem(
  int uniqueNamePtr,
  int memPtr,
  int length,
  int hashPtr,
);

@JS('Module._loadWaveform')
external int _loadWaveform(
    int waveform, bool superWave, double scale, double detune, int hashPtr);

@JS('Module._play')
external int _play(int soundHash, double volume, double pan, bool paused,
    bool looping, double loopingStartAt, int handlePtr);

class JSSoloud {
  JSSoloud._();

  static int malloc(int bytesCount) => _malloc(bytesCount);

  static int getValue(int ptrAddress, String type) =>
      _getValue(ptrAddress, type);

  static void setValue(int ptrAddress, int value, String type) =>
      _setValue(ptrAddress, value, type);

  static void free(int ptrAddress) => _free(ptrAddress);

  static JSFunction cwrap(
    JSString fName,
    JSString returnType,
    JSArray<JSString> argTypes,
  ) =>
      _cwrap(fName, returnType, argTypes);

  static JSFunction ccall(
    JSString fName,
    JSString returnType,
    JSArray<JSString> argTypes,
    JSArray<JSAny> args,
  ) =>
      _ccall(fName, returnType, argTypes, args);

  static int initEngine() => _initEngine();

  static void deinit() => _dispose();

  static int isInited() => _isInited();

  static int loadFile(int completeFileNamePtr, bool loadIntoMem, int hashPtr) =>
      _loadFile(completeFileNamePtr, loadIntoMem, hashPtr);

  static int loadMem(
    int uniqueNamePtr,
    int memPtr,
    int length,
    int hashPtr,
  ) =>
      _loadMem(uniqueNamePtr, memPtr, length, hashPtr);

  static int loadWaveform(int waveform, bool superWave, double scale,
          double detune, int hashPtr) =>
      _loadWaveform(waveform, superWave, scale, detune, hashPtr);

  static int play(int soundHash, double volume, double pan, bool paused,
          bool looping, double loopingStartAt, int handlePtr) =>
      _play(soundHash, volume, pan, paused, looping, loopingStartAt, handlePtr);
}
