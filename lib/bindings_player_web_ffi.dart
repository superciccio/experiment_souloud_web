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
/// AudioIsolate should be rewritten using web.Worker
/// 
/// 
@JS('Module')
@staticInterop
external JSObject wasmModule;

@JS('Module._malloc')
@staticInterop
external int malloc(int bytesCount);

@JS('Module._free')
external void free(int ptrAddress);

@JS('Module.getValue')
external int getValue(int ptrAddress, String type);

@JS('Module.setValue')
external void setValue(int ptrAddress, int value, String type);

@JS('Module.cwrap')
external JSFunction cwrap(
  JSString fName,
  JSString returnType,
  JSArray<JSString> argTypes,
);

@JS('Module.ccall')
external JSFunction ccall(
  JSString fName,
  JSString returnType,
  JSArray<JSString> argTypes,
  JSArray<JSAny> args,
);

@JS('Module._initEngine')
external int initEngine();

@JS('Module._dispose')
external void dispose();

@JS('Module._isInited')
external int isInited();

@JS('Module._loadFile')
external int loadFile(int completeFileNamePtr, bool loadIntoMem, int hashPtr);

@JS('Module._loadMem')
external int loadMem(
  int uniqueNamePtr,
  int memPtr,
  int length,
  int hashPtr,
);

@JS('Module._loadWaveform')
external int loadWaveform(
    int waveform, bool superWave, double scale, double detune, int hashPtr);

@JS('Module._play')
external int play(int soundHash, double volume, double pan, bool paused,
    bool looping, double loopingStartAt, int handlePtr);
