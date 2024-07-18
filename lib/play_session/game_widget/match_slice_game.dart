import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class MatchSliceGame extends StatefulWidget {
  final List<String> images;
  final bool isColor;

  const MatchSliceGame({
    Key? key,
    required this.images,
    this.isColor = false,
  }) : super(key: key);

  @override
  State<MatchSliceGame> createState() => _MatchSliceGameState();
}

class _MatchSliceGameState extends State<MatchSliceGame> {
  final double height = 100.0;
  final double width = 50.0;
  final double lineHeight = 115.0;
  final double lineWidth = 2.0;
  final double scale = 3;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];

  int progress = 0;
  int subLevel = 3;
  int adjLevel = 4;

  void initGame() {
    widget.images.shuffle();
    isTrue = List.generate(adjLevel, (index) => false);
    Random().nextInt(2) == 1
        ? colors = List.generate(
            Colors.primaries.length, (index) => Colors.primaries[index])
        : colors = List.generate(
            Colors.accents.length, (index) => Colors.accents[index]);
    colors.shuffle();
    domain = List.generate(
        isTrue.length,
        (index) => {
              'data': '$index',
              'image': widget.images[index],
            });
    domain.shuffle();
    codomain = List.generate(domain.length, (index) => domain[index]);
    codomain.shuffle();
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
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: 2 * width + lineWidth,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Draggable(
                                  data: domain[index]['data'],
                                  feedback: Container(
                                    alignment: Alignment.centerRight,
                                    height: height,
                                    width: width,
                                    child: widget.isColor
                                        ? Image.asset(
                                            domain[index]['image']!,
                                            scale: scale,
                                            color: colors[int.parse(
                                                domain[index]['data']!)],
                                          )
                                        : Image.asset(domain[index]['image']!),
                                  ),
                                  childWhenDragging: Container(
                                    alignment: Alignment.centerRight,
                                    height: height,
                                    width: width,
                                    child: widget.isColor
                                        ? Image.asset(
                                            domain[index]['image']!,
                                            scale: scale,
                                            color: colors[int.parse(
                                                domain[index]['data']!)],
                                          )
                                        : Image.asset(domain[index]['image']!),
                                  ),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    height: height,
                                    width: width,
                                    child: widget.isColor
                                        ? Image.asset(
                                            domain[index]['image']!,
                                            scale: scale,
                                            color: colors[int.parse(
                                                domain[index]['data']!)],
                                          )
                                        : Image.asset(domain[index]['image']!),
                                  ),
                                ),
                                Container(
                                  width: lineWidth,
                                  height: lineHeight,
                                  color: Colors.black,
                                ),
                                Container(
                                  width: width,
                                  height: height,
                                  color: Colors.white,
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15);
                          },
                          itemCount: isTrue.length),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: 2 * width + lineWidth,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                DragTarget(builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    alignment: Alignment.centerRight,
                                    height: height,
                                    width: width,
                                    child: isTrue[index]
                                        ? widget.isColor
                                            ? Image.asset(
                                                codomain[index]['image']!,
                                                scale: scale,
                                                color: colors[int.parse(
                                                    codomain[index]['data']!)],
                                              )
                                            : Image.asset(
                                                codomain[index]['image']!)
                                        : Container(
                                            height: height,
                                            width: width,
                                            color: Colors.white,
                                          ),
                                  );
                                }, onAcceptWithDetails:
                                    (DragTargetDetails details) {
                                  if (details.data == codomain[index]['data']) {
                                    setState(() {
                                      isTrue[index] = true;
                                    });
                                    winGame();
                                  }
                                }),
                                isTrue[index]
                                    ? Container(height: lineHeight)
                                    : Container(
                                        width: lineWidth,
                                        height: lineHeight,
                                        color: Colors.black,
                                      ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: width,
                                  height: height,
                                  child: Transform.flip(
                                    flipX: true,
                                    child: widget.isColor
                                        ? Image.asset(
                                            codomain[index]['image']!,
                                            scale: scale,
                                            color: colors[int.parse(
                                                codomain[index]['data']!)],
                                          )
                                        : Image.asset(
                                            codomain[index]['image']!),
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15);
                          },
                          itemCount: isTrue.length),
                    )
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal &&
                    isTrue.every((element) => element == true)
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
