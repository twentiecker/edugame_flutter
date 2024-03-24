import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../game/flappy_bird.dart';
import '../utils/assets.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBird> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
