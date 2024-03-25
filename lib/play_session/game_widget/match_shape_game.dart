import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/palette.dart';

class MatchShapeGame extends StatefulWidget {
  const MatchShapeGame({Key? key}) : super(key: key);

  @override
  State<MatchShapeGame> createState() => _MatchShapeGameState();
}

class _MatchShapeGameState extends State<MatchShapeGame> {
  bool isCircle = false;
  bool isSquare = false;
  bool isTriangle = false;
  List<Map<String, String>> gameData = [
    {'data': 'circle', 'shape': 'assets/images/shape2d/circle'},
    {'data': 'square', 'shape': 'assets/images/shape2d/square'},
    {'data': 'triangle', 'shape': 'assets/images/shape2d/triangle'}
  ];

  @override
  void initState() {
    super.initState();
    gameData.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (isCircle && isSquare && isTriangle) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              data: gameData[0]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('${gameData[0]['shape']!}.png').image,
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: palette.backgroundLevelSelection),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('${gameData[0]['shape']!}.png').image,
                  ),
                ),
              ),
            ),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: isCircle
                          ? Image.asset('${gameData[2]['shape']!}.png').image
                          : Image.asset('${gameData[2]['shape']!}_shadow.png')
                              .image),
                ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == gameData[2]['data']) {
                setState(() {
                  isCircle = true;
                });

                winGame();
              }
            })
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              data: gameData[1]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('${gameData[1]['shape']!}.png').image,
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: palette.backgroundLevelSelection),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('${gameData[1]['shape']!}.png').image,
                  ),
                ),
              ),
            ),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: isSquare
                          ? Image.asset('${gameData[0]['shape']!}.png').image
                          : Image.asset('${gameData[0]['shape']!}_shadow.png')
                              .image),
                ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == gameData[0]['data']) {
                setState(() {
                  isSquare = true;
                });

                winGame();
              }
            })
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              data: gameData[2]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('${gameData[2]['shape']!}.png').image,
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: palette.backgroundLevelSelection),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('${gameData[2]['shape']!}.png').image,
                  ),
                ),
              ),
            ),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: isTriangle
                          ? Image.asset('${gameData[1]['shape']!}.png').image
                          : Image.asset('${gameData[1]['shape']!}_shadow.png')
                              .image),
                ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == gameData[1]['data']) {
                setState(() {
                  isTriangle = true;
                });

                winGame();
              }
            })
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
