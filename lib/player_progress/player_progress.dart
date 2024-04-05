// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:basic/level_selection/levels.dart';
import 'package:flutter/foundation.dart';

import 'persistence/local_storage_player_progress_persistence.dart';
import 'persistence/player_progress_persistence.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {
  static const maxHighestScoresPerPlayer = 10;

  /// By default, settings are persisted using
  /// [LocalStoragePlayerProgressPersistence] (i.e. NSUserDefaults on iOS,
  /// SharedPreferences on Android or local storage on the web).
  final PlayerProgressPersistence _store;

  int _index = 0;
  List<String> _highestLevelReached = [];

  /// Creates an instance of [PlayerProgress] backed by an injected
  /// persistence [store].
  PlayerProgress({PlayerProgressPersistence? store})
      : _store = store ?? LocalStoragePlayerProgressPersistence() {
    // _initLevel();
    // _getLatestFromStore(index);
  }

  /// The index of the game that the player play.
  int get index => _index;

  /// The highest level that the player has reached so far.
  List<String> get highestLevelReached => _highestLevelReached;

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = [];
    // _initLevel();
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
  }

  /// Set the value of the index to determine the game level
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level, int index) {
    if (level > int.parse(_highestLevelReached[index])) {
      _highestLevelReached[index] = level.toString();
      notifyListeners();

      unawaited(_store.saveHighestLevelReached(_highestLevelReached));
    }
  }

  void _initLevel() {
    for (int i = 0; i < games.length; i++) {
      _highestLevelReached.add('0');
    }
  }

  void setLevelProgress(List<String> level) {
    _highestLevelReached = level;
  }

  /// Fetches the latest data from the backing persistence store.
  Future<void> _getLatestFromStore(int index) async {
    final level = await _store.getHighestLevelReached();
    if (int.parse(level[index]) > int.parse(_highestLevelReached[index])) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (int.parse(level[index]) <
        int.parse(_highestLevelReached[index])) {
      await _store.saveHighestLevelReached(_highestLevelReached);
    }
  }
}
