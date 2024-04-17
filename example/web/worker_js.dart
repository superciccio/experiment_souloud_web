// ignore_for_file: avoid_print

import 'dart:js_interop' as js_interop;

import 'package:flutter_soloud_example/worker/web_worker_method_channel.dart';
import 'package:web/web.dart' as web;

@js_interop.JS('self')
external web.DedicatedWorkerGlobalScope get self;

Future<void> main() async {
  print('worker_js.dart init');
  //final channel = WebWorkerMethodChannel(scriptURL: 'worker_js.dart.js');
  //channel.invokeMethod('echo', 'andrea');
  final channel = WebWorkerMethodChannel(scriptURL: 'worker_js.dart.js');
  for (int i = 0; i <= 20; i++) {
    channel.invokeMethod('echo', i.toString());
  }
}
