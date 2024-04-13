import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class JigsawGame extends StatefulWidget {
  const JigsawGame({Key? key}) : super(key: key);

  @override
  State<JigsawGame> createState() => _JigsawGameState();
}

class _JigsawGameState extends State<JigsawGame> {
  bool isTrue1 = false;
  bool isTrue2 = false;
  bool isTrue3 = false;
  bool isTrue4 = false;
  bool isTrue5 = false;
  bool isTrue6 = false;
  bool isTrue7 = false;
  bool isTrue8 = false;
  bool isTrue9 = false;
  bool isTrue10 = false;
  bool isTrue11 = false;
  bool isTrue12 = false;
  List<String> jigsaw = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<String> pieces = [];
  final double scale = 2 / 1.5;

  @override
  void initState() {
    super.initState();
    for (var x in jigsaw) {
      pieces.add(x);
    }
    pieces.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (isTrue1 &&
          isTrue2 &&
          isTrue3 &&
          isTrue4 &&
          isTrue5 &&
          isTrue6 &&
          isTrue7 &&
          isTrue8 &&
          isTrue9 &&
          isTrue10 &&
          isTrue11 &&
          isTrue12) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            height: 306,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(width: 5.0),
            ),
            child: Stack(
              children: [
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return isTrue1
                      ? Image.asset(
                          'assets/images/jigsaw/${jigsaw[0]}.png',
                          scale: 1.5,
                        )
                      : Image.asset(
                          'assets/images/jigsaw/${jigsaw[0]}.png',
                          scale: 1.5,
                          color: Colors.grey.withOpacity(0.8),
                          colorBlendMode: BlendMode.modulate,
                        );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == jigsaw[0]) {
                    setState(() {
                      isTrue1 = true;
                    });

                    winGame();
                  }
                }),
                Positioned(
                  left: 67 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue2
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[1]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[1]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[1]) {
                      setState(() {
                        isTrue2 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  left: 132 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue3
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[2]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[2]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[2]) {
                      setState(() {
                        isTrue3 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  left: 219 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue4
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[3]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[3]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[3]) {
                      setState(() {
                        isTrue4 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 59 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue5
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[4]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[4]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[4]) {
                      setState(() {
                        isTrue5 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 74 * scale,
                  left: 61 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue6
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[5]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[5]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[5]) {
                      setState(() {
                        isTrue6 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 57 * scale,
                  left: 150 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue7
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[6]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[6]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[6]) {
                      setState(() {
                        isTrue7 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 73 * scale,
                  left: 210 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue8
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[7]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[7]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[7]) {
                      setState(() {
                        isTrue8 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 139 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue9
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[8]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[8]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[8]) {
                      setState(() {
                        isTrue9 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 138 * scale,
                  left: 66 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue10
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[9]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[9]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[9]) {
                      setState(() {
                        isTrue10 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 147 * scale,
                  left: 131 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue11
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[10]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[10]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[10]) {
                      setState(() {
                        isTrue11 = true;
                      });

                      winGame();
                    }
                  }),
                ),
                Positioned(
                  top: 136 * scale,
                  left: 218 * scale,
                  child: DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return isTrue12
                        ? Image.asset(
                            'assets/images/jigsaw/${jigsaw[11]}.png',
                            scale: 1.5,
                          )
                        : Image.asset(
                            'assets/images/jigsaw/${jigsaw[11]}.png',
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == jigsaw[11]) {
                      setState(() {
                        isTrue12 = true;
                      });

                      winGame();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    data: pieces[0],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[0]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[0]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[0]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[1],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[1]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[1]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[1]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[2],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[2]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[2]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[2]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[3],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[3]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[3]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[3]}.png',
                      scale: 2.3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    data: pieces[4],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[4]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[4]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[4]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[5],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[5]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[5]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[5]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[6],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[6]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[6]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[6]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[7],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[7]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[7]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[7]}.png',
                      scale: 2.3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable(
                    data: pieces[8],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[8]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[8]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[8]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[9],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[9]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[9]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[9]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[10],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[10]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[10]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[10]}.png',
                      scale: 2.3,
                    ),
                  ),
                  Draggable(
                    data: pieces[11],
                    feedback: Image.asset(
                      'assets/images/jigsaw/${pieces[11]}.png',
                      scale: 2.3,
                    ),
                    childWhenDragging: Image.asset(
                      'assets/images/jigsaw/${pieces[11]}.png',
                      scale: 2.3,
                    ),
                    child: Image.asset(
                      'assets/images/jigsaw/${pieces[11]}.png',
                      scale: 2.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
