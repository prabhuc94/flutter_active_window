import 'dart:async';

import 'active_window.dart';
import 'active_window_info.dart';

class ActiveWindowObserver {
  final StreamController<ActiveWindowInfo?> _controller = StreamController.broadcast(sync: true);

  Timer? _infoReaderTimer;

  ActiveWindowInfo? _windowInfo;

  ActiveWindowInfo? get windowInfo => _windowInfo;

  Stream<ActiveWindowInfo?> get stream => _controller.stream;

  Future<void> start({intervalInSeconds = 5}) async {
    _infoReaderTimer?.cancel();
    _infoReaderTimer = Timer.periodic(Duration(seconds: intervalInSeconds), (timer) async {
      final value = await ActiveWindow.getActiveWindowInfo;
      _controller.add(value);
    });
  }

  void close() {
    _infoReaderTimer?.cancel();
    _infoReaderTimer = null;
    _controller.close();
  }

  StreamSubscription<ActiveWindowInfo?> listen(
    void Function(ActiveWindowInfo?)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.distinct((a, b) => a == b).listen(
          onData,
          cancelOnError: cancelOnError,
          onDone: onDone,
          onError: onError,
        );
  }
}
