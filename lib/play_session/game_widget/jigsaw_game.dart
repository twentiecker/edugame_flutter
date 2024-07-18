import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class JigsawGame extends StatefulWidget {
  final List<String> images;

  const JigsawGame({Key? key, required this.images}) : super(key: key);

  @override
  State<JigsawGame> createState() => _JigsawGameState();
}

class _JigsawGameState extends State<JigsawGame> {
  final double scale = 2 / 1.5;

  List<bool> isTrue = [];
  List<String> pieces = [];

  void initGame() {
    isTrue = List.generate(widget.images.length, (index) => false);
    pieces = List.generate(isTrue.length, (index) => widget.images[index]);
    pieces.shuffle();
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
      if (isTrue.every((element) => element == true)) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
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
                    return isTrue[0]
                        ? Image.asset(
                            widget.images[0],
                            scale: 1.5,
                          )
                        : Image.asset(
                            widget.images[0],
                            scale: 1.5,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == widget.images[0]) {
                      setState(() {
                        isTrue[0] = true;
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
                      return isTrue[1]
                          ? Image.asset(
                              widget.images[1],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[1],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[1]) {
                        setState(() {
                          isTrue[1] = true;
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
                      return isTrue[2]
                          ? Image.asset(
                              widget.images[2],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[2],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[2]) {
                        setState(() {
                          isTrue[2] = true;
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
                      return isTrue[3]
                          ? Image.asset(
                              widget.images[3],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[3],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[3]) {
                        setState(() {
                          isTrue[3] = true;
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
                      return isTrue[4]
                          ? Image.asset(
                              widget.images[4],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[4],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[4]) {
                        setState(() {
                          isTrue[4] = true;
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
                      return isTrue[5]
                          ? Image.asset(
                              widget.images[5],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[5],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[5]) {
                        setState(() {
                          isTrue[5] = true;
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
                      return isTrue[6]
                          ? Image.asset(
                              widget.images[6],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[6],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[6]) {
                        setState(() {
                          isTrue[6] = true;
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
                      return isTrue[7]
                          ? Image.asset(
                              widget.images[7],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[7],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[7]) {
                        setState(() {
                          isTrue[7] = true;
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
                      return isTrue[8]
                          ? Image.asset(
                              widget.images[8],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[8],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[8]) {
                        setState(() {
                          isTrue[8] = true;
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
                      return isTrue[9]
                          ? Image.asset(
                              widget.images[9],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[9],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[9]) {
                        setState(() {
                          isTrue[9] = true;
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
                      return isTrue[10]
                          ? Image.asset(
                              widget.images[10],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[10],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[10]) {
                        setState(() {
                          isTrue[10] = true;
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
                      return isTrue[11]
                          ? Image.asset(
                              widget.images[11],
                              scale: 1.5,
                            )
                          : Image.asset(
                              widget.images[11],
                              scale: 1.5,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == widget.images[11]) {
                        setState(() {
                          isTrue[11] = true;
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
                        pieces[0],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[0],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[0],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[1],
                      feedback: Image.asset(
                        pieces[1],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[1],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[1],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[2],
                      feedback: Image.asset(
                        pieces[2],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[2],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[2],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[3],
                      feedback: Image.asset(
                        pieces[3],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[3],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[3],
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
                        pieces[4],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[4],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[4],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[5],
                      feedback: Image.asset(
                        pieces[5],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[5],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[5],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[6],
                      feedback: Image.asset(
                        pieces[6],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[6],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[6],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[7],
                      feedback: Image.asset(
                        pieces[7],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[7],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[7],
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
                        pieces[8],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[8],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[8],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[9],
                      feedback: Image.asset(
                        pieces[9],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[9],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[9],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[10],
                      feedback: Image.asset(
                        pieces[10],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[10],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[10],
                        scale: 2.3,
                      ),
                    ),
                    Draggable(
                      data: pieces[11],
                      feedback: Image.asset(
                        pieces[11],
                        scale: 2.3,
                      ),
                      childWhenDragging: Image.asset(
                        pieces[11],
                        scale: 2.3,
                      ),
                      child: Image.asset(
                        pieces[11],
                        scale: 2.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
