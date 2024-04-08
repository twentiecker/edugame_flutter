import 'package:basic/play_session/game_widget/memory_game/score_board.dart';
import 'package:basic/play_session/game_widget/memory_game/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../audio/audio_controller.dart';
import '../../../audio/sounds.dart';
import '../../../game_internals/level_state.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final Utils _game = Utils();
  int tries = 0;
  int match = 0;

  @override
  void initState() {
    super.initState();
    _game.initGame();
    _game.cardList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (match == _game.cardList.length / 2) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScoreBoard(title: 'Tries', info: '$tries'),
            ScoreBoard(title: 'Match', info: '$match'),
          ],
        ),
        Expanded(
          child: SizedBox(
            child: GridView.builder(
              itemCount: _game.gameImg!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint(_game.cardList[index]);
                    setState(
                      () {
                        _game.gameImg![index] = _game.cardList[index];
                        _game.matchCheck.add({index: _game.cardList[index]});
                      },
                    );
                    if (_game.matchCheck.length == 2) {
                      if (_game.matchCheck[0].values.first ==
                          _game.matchCheck[1].values.first) {
                        debugPrint('true');
                        match += 1;
                        _game.matchCheck.clear();

                        winGame();
                      } else {
                        debugPrint('false');
                        tries++;
                        Future.delayed(
                          const Duration(milliseconds: 500),
                          () {
                            debugPrint(_game.gameImg.toString());
                            setState(
                              () {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardPath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardPath;
                                _game.matchCheck.clear();
                              },
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB46A),
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
