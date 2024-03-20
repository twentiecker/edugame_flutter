import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../game/flappy_bird.dart';
import '../game/pipe_pos.dart';
import '../utils/assets.dart';
import '../utils/config.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBird> {
  Pipe({
    required this.pipePos,
    required this.height,
  });

  @override
  final double height;
  final PipePos pipePos;

  Future<void> onLoad() async {
    final pipe = await Flame.images.load(Assets.pipe);
    final pipeRotated = await Flame.images.load(Assets.pipeRotated);
    size = Vector2(50, height);

    switch (pipePos) {
      case PipePos.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePos.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}
