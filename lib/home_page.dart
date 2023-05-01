import 'dart:async';

import 'package:bubble_man/ball.dart';
import 'package:bubble_man/button.dart';
import 'package:bubble_man/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'missile.dart';

enum Direction { left, right }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// player
  static double playerX = 0;
  final double playerY = 1;

  /// missile
  double missileX = playerX;
  final double missileY = 1;
  double missileHeight = 10;
  bool midShot = false;

  /// ball variables
  double ballX = 0.5;
  double ballY = 0;
  var ballDirection = Direction.left;
  var ballIncrement = 0.03;



  void startGame() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (ballX - ballIncrement < -1) {
        ballDirection = Direction.right;
      } else if (ballX + ballIncrement > 1) {
        ballDirection = Direction.left;
      }
      if (ballDirection == Direction.left) {
        setState(() {
          ballX -= ballIncrement;
        });
      } else if (ballDirection == Direction.right) {
        setState(() {
          ballX += ballIncrement;
        });
      }
    });
  }

  void moveLeft() {
    if (playerX - 0.1 < -1) return;
    setState(() {
      playerX -= 0.1;
    });

    /// chane missile position only when its not in middle of a shot
    if (!midShot) {
      missileX = playerX;
    }
  }

  void moveRight() {
    if (playerX + 0.1 > 1) return;
    setState(() {
      playerX += 0.1;
    });

    /// chane missile position only when its not in middle of a shot
    if (!midShot) {
      missileX = playerX;
    }
  }

  void fireMissile() {
    if (midShot == true) return;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      /// Start fire
      midShot = true;

      /// grow missile height to hit the top of the screen
      setState(() {
        missileHeight += 10;
      });

      if (missileHeight > (MediaQuery.of(context).size.height * .6)) {
        resetMissile();
        timer.cancel();

        /// End fire
        midShot = false;
      }
    });
  }

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMissile();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink.shade100,
              child: Center(
                child: Stack(
                  children: [
                    /// Ball
                    AppBall(ballX: ballX, ballY: ballY),

                    ///
                    /// Missile
                    ///
                    AppMissile(missileHeight: missileHeight, missileX: missileX, missileY: missileY),

                    ///
                    /// Player
                    ///
                    AppPlayer(playerX: playerX, playerY: playerY),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    iconData: Icons.play_arrow,
                    press: startGame,
                  ),
                  AppButton(
                    iconData: Icons.arrow_back,
                    press: moveLeft,
                  ),
                  AppButton(
                    iconData: Icons.arrow_upward,
                    press: fireMissile,
                  ),
                  AppButton(
                    iconData: Icons.arrow_forward,
                    press: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
