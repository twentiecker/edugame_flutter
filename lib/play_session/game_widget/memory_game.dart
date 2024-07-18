import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class MemoryGame extends StatefulWidget {
  final List<String> images;

  const MemoryGame({Key? key, required this.images}) : super(key: key);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final String hiddenCard = 'assets/images/memory/question.png';

  List<bool> isTrue = [];
  List<String> cardList = [];
  List<String> hiddenList = [];
  List<Map<int, String>> matchCheck = [];

  int tries = 0;
  int match = 0;

  int progress = 0;
  int subLevel = 3;
  int adjLevel = 1;

  void initGame() {
    widget.images.shuffle();
    isTrue = List.generate(adjLevel * 4, (index) => false);
    cardList = List.generate(
        isTrue.length, (index) => widget.images[index % (isTrue.length ~/ 2)]);
    cardList.shuffle();
    hiddenList = List.generate(cardList.length, (index) => hiddenCard);
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
      if (match == cardList.length / 2) {
        progress = levelState.progress + levelState.goal ~/ subLevel;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScoreWidget(title: 'Tries', point: '$tries'),
              ScoreWidget(title: 'Match', point: '$match'),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: GridView.builder(
                itemCount: isTrue.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                padding: const EdgeInsets.all(20.0),
                itemBuilder: (context, index) {
                  return isTrue[index]
                      ? Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(hiddenList[index]),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            debugPrint(cardList[index]);
                            setState(
                              () {
                                hiddenList[index] = cardList[index];
                                matchCheck.add({index: cardList[index]});
                              },
                            );
                            if (matchCheck.length == 2) {
                              if (matchCheck[0].values.first ==
                                  matchCheck[1].values.first) {
                                debugPrint('true');
                                match += 1;
                                setState(() {
                                  isTrue[matchCheck[0].keys.first] = true;
                                  isTrue[matchCheck[1].keys.first] = true;
                                });
                                matchCheck.clear();
                                winGame();
                              } else {
                                debugPrint('false');
                                tries++;
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    debugPrint(hiddenList.toString());
                                    setState(() {
                                      hiddenList[matchCheck[0].keys.first] =
                                          hiddenCard;
                                      hiddenList[matchCheck[1].keys.first] =
                                          hiddenCard;
                                      matchCheck.clear();
                                    });
                                  },
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(hiddenList[index]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal &&
                    isTrue.every((element) => element == true)
                ? MyButton(
                    onPressed: () {
                      setState(() {
                        tries = 0;
                        match = 0;
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

class ScoreWidget extends StatelessWidget {
  final String title, point;

  const ScoreWidget({
    Key? key,
    required this.title,
    required this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$title :',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              point,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
