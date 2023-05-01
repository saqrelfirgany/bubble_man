import 'package:flutter/material.dart';

class AppBall extends StatelessWidget {
  const AppBall({Key? key, required this.ballX, required this.ballY}) : super(key: key);
  final double ballX;

  final double ballY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown,
        ),
      ),
    );
  }
}
