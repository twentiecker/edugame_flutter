import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class GroupGame extends StatefulWidget {
  const GroupGame({Key? key}) : super(key: key);

  @override
  State<GroupGame> createState() => _GroupGameState();
}

class _GroupGameState extends State<GroupGame> {
  bool isRed = false;
  bool isGreen = false;
  bool isBlue = false;
  List<String> items = [
    'apple',
    'bird',
    'grape',
    'juice',
    'mug',
    'pencil',
    'shirt',
    'trees',
  ];
  List<Color> colors = [Colors.red, Colors.green, Colors.blue];
  List<String> colorNames = ['red', 'green', 'blue'];
  List<Map<String, String>> questions = [];
  List<String> red = [];
  List<String> blue = [];
  List<String> green = [];

  @override
  void initState() {
    super.initState();
    items.shuffle();
    for (var i = 0; i < items.length; i++) {
      questions.add({
        'color': Random().nextInt(colors.length).toString(),
        'item': items[i]
      });
    }
    questions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (red.length + green.length + blue.length == items.length) {
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
            for (var i = 0; i < 4; i++)
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Draggable(
                  data:
                      '${colorNames[int.parse(questions[i]['color']!)]}${questions[i]['item']}',
                  feedback: Image.asset(
                    'assets/images/group/${questions[i]['item']}.png',
                    color: colors[int.parse(questions[i]['color']!)],
                    colorBlendMode: BlendMode.modulate,
                    scale: 4,
                  ),
                  childWhenDragging: Image.asset(
                    'assets/images/group/${questions[i]['item']}.png',
                    color: colors[int.parse(questions[i]['color']!)],
                    colorBlendMode: BlendMode.modulate,
                    scale: 4,
                  ),
                  child: Image.asset(
                    'assets/images/group/${questions[i]['item']}.png',
                    color: colors[int.parse(questions[i]['color']!)],
                    colorBlendMode: BlendMode.modulate,
                    scale: 4,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 4; i < 8; i++)
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Draggable(
                  data:
                      '${colorNames[int.parse(questions[i]['color']!)]}${questions[i]['item']}',
                  feedback: Image.asset(
                    'assets/images/group/${questions[i]['item']}.png',
                    color: colors[int.parse(questions[i]['color']!)],
                    colorBlendMode: BlendMode.modulate,
                    scale: 4,
                  ),
                  childWhenDragging: Image.asset(
                    'assets/images/group/${questions[i]['item']}.png',
                    color: colors[int.parse(questions[i]['color']!)],
                    colorBlendMode: BlendMode.modulate,
                    scale: 4,
                  ),
                  child: Image.asset(
                    'assets/images/group/${questions[i]['item']}.png',
                    color: colors[int.parse(questions[i]['color']!)],
                    colorBlendMode: BlendMode.modulate,
                    scale: 4,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return isRed
                  ? Stack(
                      children: [
                        Image.asset(
                          'assets/images/group/basket.png',
                          color: Colors.red,
                          colorBlendMode: BlendMode.modulate,
                          scale: 4.5,
                        ),
                        for (var item in red)
                          Positioned(
                            top: 20,
                            left: 35,
                            child: Image.asset(
                              'assets/images/group/$item.png',
                              color: Colors.red,
                              colorBlendMode: BlendMode.modulate,
                              scale: 4,
                            ),
                          ),
                        Image.asset(
                          'assets/images/group/front.png',
                          color: Colors.red,
                          colorBlendMode: BlendMode.modulate,
                          scale: 4.5,
                        ),
                      ],
                    )
                  : Image.asset(
                      'assets/images/group/basket.png',
                      color: Colors.red,
                      colorBlendMode: BlendMode.modulate,
                      scale: 4.5,
                    );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data.toString().contains('red')) {
                setState(() {
                  isRed = true;
                  if (!red.contains(
                      details.data.toString().replaceAll('red', ''))) {
                    red.add(details.data.toString().replaceAll('red', ''));
                  }
                });

                winGame();
              }
            }),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return isGreen
                  ? Stack(
                      children: [
                        Image.asset(
                          'assets/images/group/basket.png',
                          color: Colors.green,
                          colorBlendMode: BlendMode.modulate,
                          scale: 4.5,
                        ),
                        for (var item in green)
                          Positioned(
                            top: 20,
                            left: 35,
                            child: Image.asset(
                              'assets/images/group/$item.png',
                              color: Colors.green,
                              colorBlendMode: BlendMode.modulate,
                              scale: 4,
                            ),
                          ),
                        Image.asset(
                          'assets/images/group/front.png',
                          color: Colors.green,
                          colorBlendMode: BlendMode.modulate,
                          scale: 4.5,
                        ),
                      ],
                    )
                  : Image.asset(
                      'assets/images/group/basket.png',
                      color: Colors.green,
                      colorBlendMode: BlendMode.modulate,
                      scale: 4.5,
                    );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data.toString().contains('green')) {
                setState(() {
                  isGreen = true;
                  if (!red.contains(
                      details.data.toString().replaceAll('green', ''))) {
                    green.add(details.data.toString().replaceAll('green', ''));
                  }
                });

                winGame();
              }
            }),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return isBlue
                  ? Stack(
                      children: [
                        Image.asset(
                          'assets/images/group/basket.png',
                          color: Colors.blue,
                          colorBlendMode: BlendMode.modulate,
                          scale: 4.5,
                        ),
                        for (var item in blue)
                          Positioned(
                            top: 20,
                            left: 35,
                            child: Image.asset(
                              'assets/images/group/$item.png',
                              color: Colors.blue,
                              colorBlendMode: BlendMode.modulate,
                              scale: 4,
                            ),
                          ),
                        Image.asset(
                          'assets/images/group/front.png',
                          color: Colors.blue,
                          colorBlendMode: BlendMode.modulate,
                          scale: 4.5,
                        ),
                      ],
                    )
                  : Image.asset(
                      'assets/images/group/basket.png',
                      color: Colors.blue,
                      colorBlendMode: BlendMode.modulate,
                      scale: 4.5,
                    );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data.toString().contains('blue')) {
                setState(() {
                  isBlue = true;
                  if (!blue.contains(
                      details.data.toString().replaceAll('blue', ''))) {
                    blue.add(details.data.toString().replaceAll('blue', ''));
                  }
                });

                winGame();
              }
            }),
          ],
        ),
      ],
    );
  }
}
