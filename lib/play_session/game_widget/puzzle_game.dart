import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({Key? key}) : super(key: key);

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  bool isCastle1 = false;
  bool isCastle2 = false;
  bool isCastle3 = false;

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (isCastle1 && isCastle2 && isCastle3) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Column(
      children: [
        DragTarget(builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return SizedBox(
            width: 300,
            height: 162,
            child: isCastle1
                ? Image.asset(
                    'assets/images/slice/castle_01.png',
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 100,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
          );
        }, onAcceptWithDetails: (DragTargetDetails details) {
          if (details.data == 'castle_01') {
            setState(() {
              isCastle1 = true;
            });

            winGame();
          }
        }),
        DragTarget(builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return SizedBox(
            width: 300,
            height: 161,
            child: isCastle2
                ? Image.asset(
                    'assets/images/slice/castle_02.png',
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 100,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
          );
        }, onAcceptWithDetails: (DragTargetDetails details) {
          if (details.data == 'castle_02') {
            setState(() {
              isCastle2 = true;
            });

            winGame();
          }
        }),
        DragTarget(builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return SizedBox(
            width: 300,
            height: 162,
            child: isCastle3
                ? Image.asset(
                    'assets/images/slice/castle_03.png',
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 100,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
          );
        }, onAcceptWithDetails: (DragTargetDetails details) {
          if (details.data == 'castle_03') {
            setState(() {
              isCastle3 = true;
            });

            winGame();
          }
        }),
        SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: Colors.blue,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Draggable(
                    data: 'castle_01',
                    feedback: SizedBox(
                      width: 300,
                      height: 162,
                      child: Image.asset(
                        'assets/images/slice/castle_01.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    childWhenDragging: Container(),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      width: 186,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/images/slice/castle_01.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Draggable(
                    data: 'castle_02',
                    feedback: SizedBox(
                      width: 300,
                      height: 162,
                      child: Image.asset(
                        'assets/images/slice/castle_02.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    childWhenDragging: Container(),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      width: 186,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/images/slice/castle_02.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Draggable(
                    data: 'castle_03',
                    feedback: SizedBox(
                      width: 300,
                      height: 162,
                      child: Image.asset(
                        'assets/images/slice/castle_03.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    childWhenDragging: Container(),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      width: 186,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/images/slice/castle_03.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
