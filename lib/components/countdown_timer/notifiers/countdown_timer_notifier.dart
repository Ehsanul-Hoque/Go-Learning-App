import "dart:async";

import "package:app/components/countdown_timer/enums/countdown_timer_state.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart" show BuildContext, ChangeNotifier;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";

class CountdownTimerNotifier extends ChangeNotifier {
  /// Default constructor
  CountdownTimerNotifier({
    Duration? totalDuration,
    Duration? tickDuration,
  })  : _totalDuration = totalDuration ?? const Duration(seconds: 0),
        _tickDuration = tickDuration ?? const Duration(seconds: 1);

  // Fields
  Duration _totalDuration, _tickDuration;
  CountdownTimerState _state = CountdownTimerState.initialized;
  Timer? _timer, _periodicTimer;
  int _prevTick = 0;
  int _tick = 0;

  // Getters of the fields
  Duration get totalDuration => _totalDuration;
  Duration get tickDuration => _tickDuration;
  bool get isValidDurations =>
      _totalDuration.inSeconds > 0 && _tickDuration.inSeconds > 0;
  int get tick => _tick;
  CountdownTimerState get state => _state;

  // Setters of the fields
  set totalDuration(Duration duration) {
    if (state == CountdownTimerState.running) {
      Utils.log(
        "Total duration cannot be changed while the countdown timer"
        "is running. Please pause or stop the timer,"
        "or let the timer finish naturally,"
        "then try to change the total duration again.",
      );
      return;
    }

    _totalDuration = duration;
    notifyListeners();
  }

  set tickDuration(Duration duration) {
    if (state == CountdownTimerState.running) {
      Utils.log(
        "Tick duration cannot be changed while the countdown timer"
        "is running. Please pause or stop the timer,"
        "or let the timer finish naturally,"
        "then try to change the tick duration again.",
      );
      return;
    }

    _tickDuration = duration;
    notifyListeners();
  }

  /// Static method to create simple provider
  static SingleChildWidget createProvider({
    Duration? totalDuration,
    Duration? tickDuration,
  }) =>
      ChangeNotifierProvider<CountdownTimerNotifier>(
        create: (BuildContext context) => CountdownTimerNotifier(
          totalDuration: totalDuration,
          tickDuration: tickDuration,
        ),
      );

  /// Method to start the countdown timer
  void start() {
    if (!isValidDurations) return;

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
        notifyListeners();
      },
    );

    _periodicTimer = Timer.periodic(
      tickDuration,
      (Timer timer) {
        _tick = _prevTick + timer.tick;
        notifyListeners();
      },
    );

    notifyListeners();
  }

  /// Method to pause the countdown timer
  void pause() {
    if (!isValidDurations) return;

    _prevTick = tick;
    _cancelTimers(resetTick: false);
    _state = CountdownTimerState.paused;
  }

  /// Method to resume the countdown timer
  void resume() {
    if (!isValidDurations) return;

    if (state != CountdownTimerState.finished) {
      start();
    }
  }

  /// Method to stop the countdown timer
  void stop() {
    if (!isValidDurations) return;

    if (state != CountdownTimerState.finished) {
      _cancelTimers();
      _state = CountdownTimerState.stopped;
    }
  }

  /// Method to restart the countdown timer
  void restart() {
    if (!isValidDurations) return;

    _cancelTimers();
    start();
  }

  /// Method to finish the countdown timer immediately,
  /// but preserve the last time (pause to preserve, stop to reset)
  void finishNow() {
    if (!isValidDurations) return;

    pause();
    _state = CountdownTimerState.finished;
    notifyListeners();
  }

  /// Method to get the current progress of the countdown timer
  /// (between 0 and 1 (inclusive))
  double getCurrentProgress() {
    double progress =
        (tickDuration.inMilliseconds * tick) / totalDuration.inMilliseconds;

    if (progress > 1) return 1;
    if (progress < 0) return 0;
    return progress;
  }

  /// Method to cancel all timer objects and reset the tick if necessary
  void _cancelTimers({bool resetTick = true}) {
    if (_timer?.isActive == true) _timer?.cancel();
    if (_periodicTimer?.isActive == true) _periodicTimer?.cancel();
    if (resetTick) _tick = 0;
  }
}
