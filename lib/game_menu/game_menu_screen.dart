import 'package:basic/level_selection/levels.dart';
import 'package:basic/style/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';

class GameMenuScreen extends StatelessWidget {
  const GameMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        squarishMainArea: ListView.builder(
            itemCount: games.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    games[index].game,
                    style: TextStyle(
                      fontFamily: 'Permanent Marker',
                      fontSize: 25,
                      height: 1,
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      GoRouter.of(context).go('/play/$index');
                    },
                    child: const Text('Play'),
                  )
                ],
              );
            }),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}
