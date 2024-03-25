import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class CompletePatternGame extends StatefulWidget {
  const CompletePatternGame({Key? key}) : super(key: key);

  @override
  State<CompletePatternGame> createState() => _CompletePatternGameState();
}

class _CompletePatternGameState extends State<CompletePatternGame> {
  bool isTrue = false;
  List<Map<String, String>> gameData = [
    {'data': 'circle', 'shape': 'assets/images/shape2d/circle.png'},
    {'data': 'square', 'shape': 'assets/images/shape2d/square.png'},
    {'data': 'triangle', 'shape': 'assets/images/shape2d/triangle.png'},
    {'data': 'star', 'shape': 'assets/images/shape2d/star.png'}
  ];
  Map<String, String> shape1 = {};
  Map<String, String> shape2 = {};

  @override
  void initState() {
    super.initState();
    gameData.shuffle();
    shape1 = gameData[Random().nextInt(gameData.length)];
    while (true) {
      shape2 = gameData[Random().nextInt(gameData.length)];
      if (shape1 != shape2) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (isTrue) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Draggable(
              data: gameData[0]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[0]['shape']!),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[0]['shape']!),
              ),
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[0]['shape']!),
              ),
            ),
            SizedBox(height: 10),
            Draggable(
              data: gameData[1]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[1]['shape']!),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[1]['shape']!),
              ),
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[1]['shape']!),
              ),
            ),
            SizedBox(height: 10),
            Draggable(
              data: gameData[2]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[2]['shape']!),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[2]['shape']!),
              ),
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[2]['shape']!),
              ),
            ),
            SizedBox(height: 10),
            Draggable(
              data: gameData[3]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[3]['shape']!),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[3]['shape']!),
              ),
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(gameData[3]['shape']!),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        Column(
          children: [
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(shape1['shape']!),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(shape2['shape']!),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(shape1['shape']!),
            ),
            SizedBox(height: 10),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isTrue ? Image.asset(shape2['shape']!) : Text(''),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == shape2['data']) {
                setState(() {
                  isTrue = true;
                });

                winGame();
              }
            })
          ],
        )
      ],
    );
  }
}
