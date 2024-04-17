import 'package:disposing/disposing.dart';
import 'package:flutter_soloud_example/worker/web_worker_method_channel.dart';
import 'package:flutter_soloud_example/worker/worker.dart';
import 'package:meta/meta.dart';

@internal
WebWorkerMethodChannel getWebWorkerMethodChannel(
        {required String scriptURL, Worker? worker}) =>
    WebWorkerMethodChannelStub();

/// A stub implementation of the [WebWorkerMethodChannel] interface.
/// This class provides default implementations for the methods defined in the [WebWorkerMethodChannel] interface.
class WebWorkerMethodChannelStub implements WebWorkerMethodChannel {
  @override
  Future<Object?> invokeMethod(String method, [Object? body]) {
    throw UnimplementedError();
  }

  @override
  SyncDisposable setMethodCallHandler(
      String method, MethodCallHandler handler) {
    throw UnimplementedError();
  }
}
