import 'package:flutter/material.dart';

class AppPlayer extends StatelessWidget {
  const AppPlayer({Key? key, required this.playerX, required this.playerY}) : super(key: key);
  final double playerX;
  final double playerY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, playerY),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
