import 'dart:async';

class MTimer {
  static int seconds;

  static final MTimer _singleton = MTimer._internal();
  static Timer timer;
  factory MTimer() {
    return _singleton;
  }

  MTimer._internal();
  count(var function) {
    timer = Timer.periodic(Duration(seconds: 1), (timers) {
      function();
    });
  }
}
