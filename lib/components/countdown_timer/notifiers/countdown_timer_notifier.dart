import "dart:async";

import "package:app/components/countdown_timer/enums/countdown_timer_state.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;

class CountdownTimerNotifier extends ChangeNotifier {
  final Duration totalDuration, tickDuration;
  Timer? _timer, _periodicTimer;

  int _prevTick = 0;
  int _tick = 0;
  int get tick => _tick;

  CountdownTimerState _state = CountdownTimerState.initialized;
  CountdownTimerState get state => _state;

  CountdownTimerNotifier({
    required this.totalDuration,
    this.tickDuration = const Duration(seconds: 1),
  });

  int prevTickMillis = 0;

  void start() {
    _cancelTimers(resetTick: false);
    _state = CountdownTimerState.running;

    _timer = Timer(
      Duration(
        milliseconds:
            totalDuration.inMilliseconds - (tickDuration.inMilliseconds * tick),
      ),
      () {
        _tick =
            (totalDuration.inMilliseconds / tickDuration.inMilliseconds).ceil();
        _cancelTimers(resetTick: false);
        _state = CountdownTimerState.finished;

        DateTime currentTime = DateTime.now();
        prevTickMillis = currentTime.millisecondsSinceEpoch;

        notifyListeners();
      },
    );

    _periodicTimer = Timer.periodic(
      tickDuration,
      (Timer timer) {
        _tick = _prevTick + timer.tick;

        DateTime currentTime = DateTime.now();
        prevTickMillis = currentTime.millisecondsSinceEpoch;

        notifyListeners();
      },
    );

    notifyListeners();
  }

  void pause() {
    _prevTick = tick;
    _cancelTimers(resetTick: false);
    _state = CountdownTimerState.paused;
  }

  void resume() {
    if (state != CountdownTimerState.finished) {
      start();
    }
  }

  void stop() {
    if (state != CountdownTimerState.finished) {
      _cancelTimers();
      _state = CountdownTimerState.stopped;
    }
  }

  void restart() {
    _cancelTimers();
    start();
  }

  double getCurrentProgress() {
    double progress =
        (tickDuration.inMilliseconds * tick) / totalDuration.inMilliseconds;

    if (progress > 1) return 1;
    if (progress < 0) return 0;
    return progress;
  }

  void _cancelTimers({bool resetTick = true}) {
    if (_timer?.isActive == true) _timer?.cancel();
    if (_periodicTimer?.isActive == true) _periodicTimer?.cancel();
    if (resetTick) _tick = 0;
  }
}
