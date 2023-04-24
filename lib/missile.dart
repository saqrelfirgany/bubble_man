import 'package:flutter/material.dart';

class AppMissile extends StatelessWidget {
  const AppMissile({
    Key? key,
    required this.missileX,
    required this.missileY,
    required this.missileHeight,
  }) : super(key: key);
  final double missileX;
  final double missileY;
  final double missileHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        width: 3,
        height: missileHeight,
        color: Colors.grey,
      ),
    );
  }
}
