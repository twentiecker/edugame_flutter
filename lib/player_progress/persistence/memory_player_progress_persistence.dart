// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../level_selection/levels.dart';
import 'player_progress_persistence.dart';

/// An in-memory implementation of [PlayerProgressPersistence].
/// Useful for testing.
class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
  List<String> level = [];

  @override
  Future<List<String>> getHighestLevelReached() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    for (int i = 0; i < games.length; i++) {
      level.add('0');
    }
    return level;
  }

  @override
  Future<void> saveHighestLevelReached(List<String> level) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    this.level = level;
  }
}
