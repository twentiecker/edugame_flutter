import 'package:basic/games/flappy_bird_game/game/flappy_bird.dart';
import 'package:basic/games/flappy_bird_game/screens/game_over.dart';
import 'package:basic/games/flappy_bird_game/screens/main_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

class FlappyBirdGame extends StatelessWidget {
  const FlappyBirdGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = FlappyBird();
    return GameWidget(
      game: game,
      initialActiveOverlays: const [MainMenu.id],
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenu(game: game),
        'gameOver': (context, _) => GameOver(game: game),
      },
    );
  }
}
