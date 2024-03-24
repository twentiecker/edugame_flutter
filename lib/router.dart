// Copyright 2023, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/game_menu/game_menu_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'game_internals/score.dart';
import 'level_selection/level_selection_screen.dart';
import 'level_selection/levels.dart';
import 'main_menu/main_menu_screen.dart';
import 'play_session/play_session_screen.dart';
import 'settings/settings_screen.dart';
import 'style/my_transition.dart';
import 'style/palette.dart';
import 'win_game/win_game_screen.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
            path: 'play/:index',
            pageBuilder: (context, state) {
              final gameIndex = int.parse(state.pathParameters['index']!);
              return buildMyTransition<void>(
                key: ValueKey('index'),
                color: context.watch<Palette>().backgroundLevelSelection,
                child: LevelSelectionScreen(
                  index: gameIndex,
                  key: Key('level selection'),
                ),
              );
            },
            routes: [
              GoRoute(
                path: 'session/:level',
                pageBuilder: (context, state) {
                  final index = int.parse(state.pathParameters['index']!);
                  final levelNumber = int.parse(state.pathParameters['level']!);
                  final level = games[index]
                      .gameLevels
                      .singleWhere((e) => e.number == levelNumber);
                  return buildMyTransition<void>(
                    key: ValueKey('level'),
                    color: context.watch<Palette>().backgroundPlaySession,
                    child: PlaySessionScreen(
                      level,
                      key: const Key('play session'),
                      index: index,
                    ),
                  );
                },
              ),
              GoRoute(
                path: 'won',
                redirect: (context, state) {
                  if (state.extra == null) {
                    // Trying to navigate to a win screen without any data.
                    // Possibly by using the browser's back button.
                    return '/';
                  }

                  // Otherwise, do not redirect.
                  return null;
                },
                pageBuilder: (context, state) {
                  final map = state.extra! as Map<String, dynamic>;
                  final score = map['score'] as Score;
                  final index = int.parse(state.pathParameters['index']!);

                  return buildMyTransition<void>(
                    key: ValueKey('won'),
                    color: context.watch<Palette>().backgroundPlaySession,
                    child: WinGameScreen(
                      index: index,
                      score: score,
                      key: const Key('win game'),
                    ),
                  );
                },
              )
            ]),
        GoRoute(
          path: 'settings',
          builder: (context, state) =>
              const SettingsScreen(key: Key('settings')),
        ),
        GoRoute(
          path: 'games',
          builder: (context, state) => const GameMenuScreen(key: Key('games')),
        ),
      ],
    ),
  ],
);
