import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_soloud_example/worker/logger_mixin.dart';
import 'package:flutter_soloud_example/worker/web_worker_method_channel.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget with LoggerMixin {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterSoloudPlugin = FlutterSoloud();
  int soundHash = 0;
  late final WebWorkerMethodChannel channel;

  Logger get logger => getLogger('${runtimeType} ');

  @override
  void initState() {
    super.initState();
    initPlatformState();

    () async {
      channel = WebWorkerMethodChannel(scriptURL: './web/worker_js.dart.js');

      channel.setMethodCallHandler('echo', (body) {
        print(body);
        return body;
      });
    }();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterSoloudPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              OutlinedButton(
                onPressed: () {
                  _flutterSoloudPlugin.init();
                },
                child: const Text('init'),
              ),
              OutlinedButton(
                onPressed: () async {
                  var sound = await _flutterSoloudPlugin.loadWaveform();
                  soundHash = sound.soundHash.hash;
                },
                child: const Text('load waveform'),
              ),
              OutlinedButton(
                onPressed: () async {
                  final result = await FilePicker.platform
                      .pickFiles(type: FileType.any, allowMultiple: false);

                  if (result != null && result.files.isNotEmpty) {
                    final fileBytes = result.files.first.bytes;
                    final fileName = result.files.first.name;

                    var sound = await _flutterSoloudPlugin.loadMem(
                      fileName,
                      fileBytes!,
                    );
                    soundHash = sound.soundHash.hash;
                  }
                },
                child: const Text('load mem'),
              ),
              OutlinedButton(
                onPressed: () {
                  _flutterSoloudPlugin.play(soundHash);
                },
                child: const Text('play'),
              ),
              OutlinedButton(
                onPressed: () {
                  _flutterSoloudPlugin.deinit();
                },
                child: const Text('dispose'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
