import 'dart:math';

import 'package:basic/games/flappy_bird_game/component/pipe.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../game/flappy_bird.dart';
import '../game/pipe_pos.dart';
import '../utils/assets.dart';
import '../utils/config.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBird> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 150 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll(
      [
        Pipe(pipePos: PipePos.top, height: centerY - spacing / 2),
        Pipe(
            pipePos: PipePos.bottom,
            height: heightMinusGround - (centerY + spacing / 2)),
      ],
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
