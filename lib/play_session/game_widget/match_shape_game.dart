import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/base_color.dart';
import '../../style/my_button.dart';

class MatchShapeGame extends StatefulWidget {
  final String title;
  final List<String> images;
  final String category;
  final bool isColor;
  final double scale;
  final List<String> hijaiyahSound;
  final bool isHijaiyah;

  const MatchShapeGame({
    Key? key,
    required this.title,
    required this.images,
    required this.category,
    this.isColor = true,
    required this.scale,
    this.hijaiyahSound = const [],
    this.isHijaiyah = false,
  }) : super(key: key);

  @override
  State<MatchShapeGame> createState() => _MatchShapeGameState();
}

class _MatchShapeGameState extends State<MatchShapeGame> {
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isTrue = [];
  List<bool> isTrueId = [];
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
  List<String> hijaiyahSounds = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 2;
  int adj = 0;

  void initGame() {
    if (widget.isHijaiyah) {
      hijaiyahSounds =
          List.generate(30, (index) => widget.hijaiyahSound[index]);
    }
    widget.images.shuffle();
    isTrue = List.generate(adjLevel, (index) => false);
    isTrueId = List.generate(adjLevel, (index) => false);
    colors.shuffle();
    domain = List.generate(
      isTrue.length,
      (index) => {
        'data': '$index',
        'shape': widget.images[index],
      },
    );
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
                        isTrueId[index]
                            ? Stack(
                                children: [
                                  widget.isColor
                                      ? Image.asset(
                                          'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                          scale: widget.scale,
                                          color: colors[int.parse(
                                                  '${domain[index]['data']}')]
                                              .color,
                                        )
                                      : Image.asset(
                                          'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                          scale: widget.scale,
                                        ),
                                  widget.isColor
                                      ? Image.asset(
                                          'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                          scale: widget.scale,
                                          color: Colors.lightGreenAccent
                                              .withOpacity(0.8),
                                        )
                                      : Image.asset(
                                          'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                          scale: widget.scale,
                                          color: Colors.lightGreenAccent
                                              .withOpacity(0.8),
                                        ),
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 35,
                                    color: Colors.green,
                                  )
                                ],
                              )
                            : Draggable(
                                data: {
                                  'id': index,
                                  'data': domain[index]['data'],
                                  'shape': domain[index]['shape']
                                },
                                feedback: widget.isColor
                                    ? Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        scale: widget.scale,
                                        color: colors[int.parse(
                                                '${domain[index]['data']}')]
                                            .color,
                                      )
                                    : Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        scale: widget.scale,
                                      ),
                                childWhenDragging: widget.isColor
                                    ? Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        scale: widget.scale,
                                        color: colors[int.parse(
                                                '${domain[index]['data']}')]
                                            .color,
                                      )
                                    : Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        scale: widget.scale,
                                      ),
                                child: widget.isColor
                                    ? Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        scale: widget.scale,
                                        color: colors[int.parse(
                                                '${domain[index]['data']}')]
                                            .color,
                                      )
                                    : Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        scale: widget.scale,
                                      ),
                              ),
                        DragTarget(builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return isTrue[index]
                              ? widget.isColor
                                  ? Image.asset(
                                      'assets/images/${widget.category}/${codomain[index]['shape']!}.png',
                                      scale: widget.scale,
                                      color: colors[int.parse(
                                              '${codomain[index]['data']}')]
                                          .color,
                                    )
                                  : Image.asset(
                                      'assets/images/${widget.category}/${codomain[index]['shape']!}.png',
                                      scale: widget.scale,
                                    )
                              : widget.isColor
                                  ? Image.asset(
                                      'assets/images/${widget.category}/${codomain[index]['shape']!}.png',
                                      scale: widget.scale,
                                      color: Colors.black38,
                                    )
                                  : Image.asset(
                                      'assets/images/${widget.category}/${codomain[index]['shape']!}.png',
                                      scale: widget.scale,
                                      color: Colors.black38,
                                    );
                        }, onAcceptWithDetails: (DragTargetDetails details) {
                          if (details.data['data'] == codomain[index]['data']) {
                            widget.isHijaiyah
                                ? FlameAudio.play(
                                    '${hijaiyahSounds[int.parse('${details.data['shape']}') - 1]}.aac')
                                : flutterTts.speak('${details.data['shape']}');
                            // flutterTts.speak('${details.data['shape']}');
                            setState(() {
                              isTrueId[int.parse('${details.data['id']}')] =
                                  true;
                              isTrue[index] = true;
                            });
                            winGame();
                          }
                        })
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 25);
                  },
                  itemCount: isTrue.length)),
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
                                  if ((adjLevel + adj) > widget.images.length) {
                                    adj = 0;
                                  }
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                  if ((adjLevel + adj) > widget.images.length) {
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
                          if ((adjLevel + adj) > widget.images.length) {
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
