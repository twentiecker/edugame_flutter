import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';

import '../game/flappy_bird.dart';
import '../utils/assets.dart';
import '../utils/config.dart';

class Ground extends ParallaxComponent<FlappyBird>
    with HasGameRef<FlappyBird> {
  Ground();

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax(
      [
        ParallaxLayer(
          ParallaxImage(ground, fill: LayerFill.none),
        ),
      ],
    );

    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - Config.groundHeight),
        size: Vector2(gameRef.size.x, Config.groundHeight),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}
