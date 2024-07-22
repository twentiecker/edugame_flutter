// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

/// An extremely silly example of a game state.
///
/// Tracks only a single variable, [progress], and calls [onWin] when
/// the value of [progress] reaches [goal].
class LevelState extends ChangeNotifier {
  final VoidCallback onWin;

  final int goal;

  LevelState({required this.onWin, this.goal = 100});

  int _progress = 0;

  int get progress => _progress;

  double _prob = 0.0;

  double get prob => _prob;

  bool isDda = true;
  double sadThreshold = 0.1;
  double happyThreshold = 0.3;

  void setProgress(int value) {
    _progress = value;
    notifyListeners();
  }

  void setProb(double value) {
    _prob = value;
    notifyListeners();
  }

  void evaluate() {
    if (_progress >= goal) {
      onWin();
    }
  }
}
