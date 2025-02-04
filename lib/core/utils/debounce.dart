import 'dart:async';

import 'package:flutter/material.dart';

//This performs an action after some milliseconds
class Debounce {
  final int milliseconds;
  Debounce({
    this.milliseconds = 500,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    close();

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }

  void close() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}
