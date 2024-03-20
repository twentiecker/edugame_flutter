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
        squarishMainArea: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Default Flutter Game',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 25,
                    height: 1,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    GoRouter.of(context).go('/play');
                  },
                  child: const Text('Play'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Match Color Game',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 25,
                    height: 1,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    GoRouter.of(context).go('/color');
                  },
                  child: const Text('Play'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Match Shape Game',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 25,
                    height: 1,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    GoRouter.of(context).go('/shape');
                  },
                  child: const Text('Play'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Complete Pattern Game',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 25,
                    height: 1,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    GoRouter.of(context).go('/pattern');
                  },
                  child: const Text('Play'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Puzzle Game',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 25,
                    height: 1,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    GoRouter.of(context).go('/puzzle');
                  },
                  child: const Text('Play'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flappy Bird Game',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 25,
                    height: 1,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    GoRouter.of(context).go('/flappy');
                  },
                  child: const Text('Play'),
                )
              ],
            ),
          ],
        ),
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
