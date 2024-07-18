import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class GroupGame extends StatefulWidget {
  final List<String> images;

  const GroupGame({Key? key, required this.images}) : super(key: key);

  @override
  State<GroupGame> createState() => _GroupGameState();
}

class _GroupGameState extends State<GroupGame> {
  final double height = 90.0;
  final double width = 90.0;
  final double radius = 10.0;

  List<bool> isTrue = [];
  List<BaseColor> baseColor = [
    BaseColor(name: 'red', color: Colors.red),
    BaseColor(name: 'green', color: Colors.green),
    BaseColor(name: 'red', color: Colors.red),
    BaseColor(name: 'blue', color: Colors.blue),
    BaseColor(name: 'yellow', color: Colors.yellow),
    BaseColor(name: 'orange', color: Colors.orange),
    BaseColor(name: 'purple', color: Colors.purple),
    BaseColor(name: 'brown', color: Colors.brown)
  ];
  List<GameColor> gameColor = [];
  List<List<dynamic>> basket = [[], [], []];

  int progress = 0;
  int subLevel = 3;
  int adjLevel = 3;

  void initGame() {
    widget.images.shuffle();
    isTrue = List.generate(3, (index) => false);
    baseColor.shuffle();
    gameColor = List.generate(adjLevel * 4, (index) {
      int indexColor = Random().nextInt(isTrue.length);
      return GameColor(
          name: baseColor[indexColor].name,
          color: baseColor[indexColor].color,
          image: widget.images[index]);
    });
    basket = [[], [], []];
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (basket[0].length + basket[1].length + basket[2].length ==
          gameColor.length) {
        progress = levelState.progress + levelState.goal ~/ subLevel;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = index * 0 + index * 4; i < index * 4 + 4; i++)
                      Draggable(
                        data: gameColor[i],
                        feedback: SizedBox(
                          width: width,
                          height: height,
                          child: Image.asset(
                            gameColor[i].image,
                            color: gameColor[i].color,
                            colorBlendMode: BlendMode.modulate,
                            scale: 4,
                          ),
                        ),
                        childWhenDragging: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: Colors.white),
                          child: Image.asset(
                            gameColor[i].image,
                            color: gameColor[i].color,
                            colorBlendMode: BlendMode.modulate,
                            scale: 4,
                          ),
                        ),
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: Colors.white),
                          child: Image.asset(
                            gameColor[i].image,
                            color: gameColor[i].color,
                            colorBlendMode: BlendMode.modulate,
                            scale: 4,
                          ),
                        ),
                      ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: adjLevel),
          SizedBox(height: 50),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DragTarget(builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return isTrue[index]
                          ? Stack(
                              children: [
                                Image.asset(
                                  'assets/images/group/basket.png',
                                  color: baseColor[index].color,
                                  colorBlendMode: BlendMode.modulate,
                                  scale: 4.5,
                                ),
                                for (var data in basket[index])
                                  Positioned(
                                    top: 20,
                                    left: 35,
                                    child: Image.asset(
                                      '${data.image}',
                                      color: baseColor[index].color,
                                      colorBlendMode: BlendMode.modulate,
                                      scale: 4,
                                    ),
                                  ),
                                Image.asset(
                                  'assets/images/group/front.png',
                                  color: baseColor[index].color,
                                  colorBlendMode: BlendMode.modulate,
                                  scale: 4.5,
                                ),
                              ],
                            )
                          : Image.asset(
                              'assets/images/group/basket.png',
                              color: baseColor[index].color,
                              colorBlendMode: BlendMode.modulate,
                              scale: 4.5,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data.name == baseColor[index].name) {
                        setState(() {
                          isTrue[index] = true;
                          if (!basket[index].contains(details.data)) {
                            basket[index].add(details.data);
                            winGame();
                          }
                        });
                      }
                    });
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 20);
                  },
                  itemCount: 3,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal &&
                    basket[0].length + basket[1].length + basket[2].length ==
                        gameColor.length
                ? MyButton(
                    onPressed: () {
                      setState(() {
                        initGame();
                      });
                    },
                    child: const Text('Next'),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class BaseColor {
  String name;
  Color color;

  BaseColor({
    required this.name,
    required this.color,
  });
}

class GameColor {
  String name;
  Color color;
  String image;

  GameColor({
    required this.name,
    required this.color,
    required this.image,
  });
}
