import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class TimerNotifier extends ChangeNotifier {
  TimerNotifier() {
    _time = 0; // _time değişkenini başlatın
  }

  late int _time;

  int get time => _time;

  final _streamController = StreamController<int>.broadcast();

  late Timer? _timer;

  Stream<int> get timerStream => _streamController.stream;

  void _countDown() {
    _time--;
    _streamController.add(_time);
  }

  void start({required Duration duration}) {
    reset(duration: duration);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countDown();
      if (_time == 0) {
        timer.cancel();
      }
    });
  }

  void reset({required Duration duration}) {
    _time = duration.inSeconds;
    _streamController.add(_time);
  }

  void restart({required Duration duration}) {
    start(duration: duration);
  }

  void setTime(int t) {
    _streamController.add(t);
    notifyListeners();
  }

  void close() {
    _timer?.cancel();
    _timer = null;
    _streamController.close();
  }
}

final timerProvider =
    ChangeNotifierProvider.autoDispose<TimerNotifier>((ref) => TimerNotifier());
