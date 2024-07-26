import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/base_color.dart';
import '../../style/my_button.dart';

class MatchSliceGame extends StatefulWidget {
  final String title;
  final List<String> images;
  final bool isColor;
  final bool isSymmetric;

  const MatchSliceGame({
    Key? key,
    required this.title,
    required this.images,
    this.isColor = false,
    this.isSymmetric = true,
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
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isTrue = [];
  List<BaseColor> colors = [
    BaseColor(name: 'merah', color: Colors.red),
    BaseColor(name: 'merah muda', color: Colors.pink),
    BaseColor(name: 'ungu', color: Colors.purple),
    BaseColor(name: 'biru', color: Colors.blue),
    BaseColor(name: 'hijau', color: Colors.green),
    BaseColor(name: 'kuning', color: Colors.yellow),
    BaseColor(name: 'jingga', color: Colors.orange),
    BaseColor(name: 'coklat', color: Colors.brown)
  ];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 2;
  int adj = 0;

  void initGame() {
    widget.images.shuffle();
    isTrue = List.generate(adjLevel, (index) => false);
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
    flutterTts.setLanguage('id-ID');
    flutterTts.speak(widget.title);
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
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
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
                                      color: colors[
                                              int.parse(domain[index]['data']!)]
                                          .color,
                                    )
                                  : widget.isSymmetric
                                      ? Image.asset(domain[index]['image']!)
                                      : Image.asset(
                                          '${domain[index]['image']!}_01.png'),
                            ),
                            childWhenDragging: Container(
                              alignment: Alignment.centerRight,
                              height: height,
                              width: width,
                              child: widget.isColor
                                  ? Image.asset(
                                      domain[index]['image']!,
                                      scale: scale,
                                      color: colors[
                                              int.parse(domain[index]['data']!)]
                                          .color,
                                    )
                                  : widget.isSymmetric
                                      ? Image.asset(domain[index]['image']!)
                                      : Image.asset(
                                          '${domain[index]['image']!}_01.png'),
                            ),
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: height,
                              width: width,
                              child: widget.isColor
                                  ? Image.asset(
                                      domain[index]['image']!,
                                      scale: scale,
                                      color: colors[
                                              int.parse(domain[index]['data']!)]
                                          .color,
                                    )
                                  : widget.isSymmetric
                                      ? Image.asset(domain[index]['image']!)
                                      : Image.asset(
                                          '${domain[index]['image']!}_01.png'),
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
                      ),
                      Row(
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
                                                  codomain[index]['data']!)]
                                              .color,
                                        )
                                      : widget.isSymmetric
                                          ? Image.asset(
                                              codomain[index]['image']!)
                                          : Image.asset(
                                              '${codomain[index]['image']!}_01.png')
                                  : Container(
                                      height: height,
                                      width: width,
                                      color: Colors.white,
                                    ),
                            );
                          }, onAcceptWithDetails: (DragTargetDetails details) {
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
                            child: widget.isSymmetric
                                ? Transform.flip(
                                    flipX: true,
                                    child: widget.isColor
                                        ? Image.asset(
                                            codomain[index]['image']!,
                                            scale: scale,
                                            color: colors[int.parse(
                                                    codomain[index]['data']!)]
                                                .color,
                                          )
                                        : Image.asset(
                                            codomain[index]['image']!),
                                  )
                                : Image.asset(
                                    '${codomain[index]['image']!}_02.png'),
                          )
                        ],
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemCount: isTrue.length),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal &&
                    isTrue.every((element) => element == true)
                ? levelState.isDda
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(children: [
                            FaceDetectorView(),
                            MyButton(
                              onPressed: () {
                                if ((levelState.prob > 0 &&
                                        levelState.prob <
                                            levelState.sadThreshold) &&
                                    adjLevel != 1) {
                                  adj = -1;
                                } else if ((levelState.prob >=
                                            levelState.sadThreshold &&
                                        levelState.prob <=
                                            levelState.happyThreshold) ||
                                    levelState.prob == 0) {
                                  adj = 1;
                                  if ((adjLevel + adj) >= colors.length) {
                                    adj = 0;
                                  }
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                  if ((adjLevel + adj) >= colors.length) {
                                    adj = 1;
                                  }
                                } else {
                                  adj = 0;
                                }
                                setState(() {
                                  adjLevel += adj;
                                  initGame();
                                });
                              },
                              child: const Text('Next'),
                            ),
                          ]),
                        ],
                      )
                    : MyButton(
                        onPressed: () {
                          adj = 1;
                          if ((adjLevel + adj) >= colors.length) {
                            adj = 0;
                          }
                          setState(() {
                            adjLevel += adj;
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
