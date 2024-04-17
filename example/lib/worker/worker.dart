import 'package:disposing/disposing.dart';

import 'message.dart';

abstract class Worker {
  bool get isMainThread;
  void postMessage(Message message);
  void terminate();

  SyncDisposable addEventListener(
    void Function(Message data) listener, [
    void Function(Object?)? onError,
  ]);
}
