// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/play_session/game_widget/complete_pattern_game.dart';
import 'package:basic/play_session/game_widget/count_number_game.dart';
import 'package:basic/play_session/game_widget/flappy_bird_game/flappy_bird_game.dart';
import 'package:basic/play_session/game_widget/greater_number_game.dart';
import 'package:basic/play_session/game_widget/match_color_game.dart';
import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:basic/play_session/game_widget/match_slice_game.dart';
import 'package:basic/play_session/game_widget/match_sound_game.dart';
import 'package:basic/play_session/game_widget/memory_game/memory_game.dart';
import 'package:basic/play_session/game_widget/puzzle_game.dart';
import 'package:basic/play_session/game_widget/spell_game.dart';
import 'package:flutter/widgets.dart';

const games = [
  Games(
    game: 'color',
    gameWidget: MatchColorGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 50,
      ),
      GameLevel(
        number: 4,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'shape',
    gameWidget: MatchShapeGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'pattern',
    gameWidget: CompletePatternGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 50,
      ),
      GameLevel(
        number: 4,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'puzzle',
    gameWidget: PuzzleGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'flappy',
    gameWidget: FlappyBirdGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 50,
      ),
      GameLevel(
        number: 4,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'greater',
    gameWidget: GreaterNumberGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'count',
    gameWidget: CountNumberGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'sound',
    gameWidget: MatchSoundGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'memory',
    gameWidget: MemoryGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'slice',
    gameWidget: MatchSliceGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
  Games(
    game: 'spell',
    gameWidget: SpellGame(),
    gameLevels: [
      GameLevel(
        number: 1,
        difficulty: 5,
        // TODO: When ready, change these achievement IDs.
        // You configure this in App Store Connect.
        achievementIdIOS: 'first_win',
        // You get this string when you configure an achievement in Play Console.
        achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
      ),
      GameLevel(
        number: 2,
        difficulty: 42,
      ),
      GameLevel(
        number: 3,
        difficulty: 100,
        achievementIdIOS: 'finished',
        achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
      ),
    ],
  ),
];

class GameLevel {
  final int number;

  final int difficulty;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;

  final String? achievementIdAndroid;

  bool get awardsAchievement => achievementIdAndroid != null;

  const GameLevel({
    required this.number,
    required this.difficulty,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}

class Games {
  final String game;
  final Widget gameWidget;
  final List<GameLevel> gameLevels;

  const Games({
    required this.game,
    required this.gameWidget,
    required this.gameLevels,
  });
}
