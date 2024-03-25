// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

import '../../level_selection/levels.dart';
import 'player_progress_persistence.dart';

/// An implementation of [PlayerProgressPersistence] that uses
/// `package:shared_preferences`.
class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  List<String> level = [];

  @override
  Future<List<String>> getHighestLevelReached() async {
    final prefs = await instanceFuture;
    for (int i = 0; i < games.length; i++) {
      level.add('0');
    }
    return prefs.getStringList('highestLevelReached') ?? level;
  }

  @override
  Future<void> saveHighestLevelReached(List<String> level) async {
    final prefs = await instanceFuture;
    await prefs.setStringList('highestLevelReached', level);
  }
}
