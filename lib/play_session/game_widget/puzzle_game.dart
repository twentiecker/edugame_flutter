import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';
import '../../style/palette.dart';

class PuzzleGame extends StatefulWidget {
  final String title;
  final String imageKey;
  final int imageNum;

  const PuzzleGame({
    Key? key,
    required this.title,
    required this.imageKey,
    required this.imageNum,
  }) : super(key: key);

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  final double height = 134.0;
  final double width = 250.0;
  final double radius = 10.0;
  final double scrollHeight = 250.0;
  final double cardHeight = 100.0;
  final double cardWidth = 186.0;
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isTrue = [];
  List<String> images = [];
  List<String> domain = [];
  List<String> codomain = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 3;
  int next = 0;

  void initGame() {
    isTrue = List.generate(adjLevel, (index) => false);
    codomain = List.generate(
        isTrue.length,
        (index) =>
            'assets/images/puzzle/${widget.imageKey}${images[next]}_0${index + 1}.png');
    domain = List.generate(codomain.length, (index) => codomain[index]);
    domain.shuffle();
    next += 1;
  }

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('id-ID');
    flutterTts.speak(widget.title);
    images = List.generate(widget.imageNum, (index) => '$index');
    images.shuffle();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
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
          SizedBox(
            width: width,
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return DragTarget(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return SizedBox(
                      width: width,
                      height: height,
                      child: isTrue[index]
                          ? Image.asset(
                              codomain[index],
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: palette.backgroundLevelSelection,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontFamily: 'Permanent Marker',
                                    fontSize: 80,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                    );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == codomain[index]) {
                      setState(() {
                        isTrue[index] = true;
                      });
                      winGame();
                    }
                  });
                },
                itemCount: isTrue.length),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Container(
                  height: scrollHeight,
                  padding: EdgeInsets.symmetric(
                    vertical: (scrollHeight - cardHeight) / 2,
                  ),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Draggable(
                          data: domain[index],
                          feedback: Container(
                            padding: EdgeInsets.all(5.0),
                            width: cardWidth,
                            height: cardHeight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            child: Image.asset(
                              domain[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          childWhenDragging: Container(
                            padding: EdgeInsets.all(5.0),
                            width: cardWidth,
                            height: cardHeight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            child: Image.asset(
                              domain[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            width: cardWidth,
                            height: cardHeight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            child: Image.asset(
                              domain[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 10);
                      },
                      itemCount: isTrue.length),
                ),
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.keyboard_double_arrow_left_rounded,
                            size: 30,
                          ),
                          Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            size: 30,
                          ),
                        ],
                      )),
                ))
              ],
            ),
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
