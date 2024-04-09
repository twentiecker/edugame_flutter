import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class MatchSliceGame extends StatefulWidget {
  const MatchSliceGame({Key? key}) : super(key: key);

  @override
  State<MatchSliceGame> createState() => _MatchSliceGameState();
}

class _MatchSliceGameState extends State<MatchSliceGame> {
  bool isLion = false;
  bool isCat = false;
  bool isDear = false;

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (isLion && isCat && isDear) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              children: [
                Draggable(
                  data: 'lion',
                  feedback: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/1a.png'),
                  ),
                  childWhenDragging: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/1a.png'),
                  ),
                  child: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/1a.png'),
                  ),
                ),
                Container(
                  width: 3,
                  height: 170,
                  color: Colors.black,
                ),
                Container(
                  width: 68,
                  height: 150,
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Draggable(
                  data: 'cat',
                  feedback: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/2a.png'),
                  ),
                  childWhenDragging: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/2a.png'),
                  ),
                  child: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/2a.png'),
                  ),
                ),
                Container(
                  width: 3,
                  height: 170,
                  color: Colors.black,
                ),
                Container(
                  width: 68,
                  height: 150,
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Draggable(
                  data: 'dear',
                  feedback: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/3a.png'),
                  ),
                  childWhenDragging: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/3a.png'),
                  ),
                  child: Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/slice/3a.png'),
                  ),
                ),
                Container(
                  width: 3,
                  height: 170,
                  color: Colors.black,
                ),
                Container(
                  width: 68,
                  height: 150,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isLion
                        ? Image.asset('assets/images/slice/1a.png')
                        : Container(
                            height: 150,
                            width: 68,
                            color: Colors.white,
                          ),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == 'lion') {
                    setState(() {
                      isLion = true;
                    });

                    winGame();
                  }
                }),
                isLion
                    ? Container(height: 170)
                    : Container(
                        width: 3,
                        height: 170,
                        color: Colors.black,
                      ),
                Container(
                  width: 68,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/images/slice/1b.png').image),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                )
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isCat
                        ? Image.asset('assets/images/slice/2a.png')
                        : Container(
                            height: 150,
                            width: 68,
                            color: Colors.white,
                          ),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == 'cat') {
                    setState(() {
                      isCat = true;
                    });

                    winGame();
                  }
                }),
                isCat
                    ? Container(height: 170)
                    : Container(
                        width: 3,
                        height: 170,
                        color: Colors.black,
                      ),
                Container(
                  width: 68,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/images/slice/2b.png').image),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                )
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 150,
                    width: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isDear
                        ? Image.asset('assets/images/slice/3a.png')
                        : Container(
                            height: 150,
                            width: 68,
                            color: Colors.white,
                          ),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == 'dear') {
                    setState(() {
                      isDear = true;
                    });

                    winGame();
                  }
                }),
                isDear
                    ? Container(height: 170)
                    : Container(
                        width: 3,
                        height: 170,
                        color: Colors.black,
                      ),
                Container(
                  width: 68,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/images/slice/3b.png').image),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                )
              ],
            ),
            SizedBox(height: 35),
          ],
        )
      ],
    );
  }
}
