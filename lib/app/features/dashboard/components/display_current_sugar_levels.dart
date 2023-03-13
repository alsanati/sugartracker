import 'package:flutter/material.dart';

class SugarLevelCircle extends StatelessWidget {
  final int sugarLevel;
  final Color color;
  final double size;

  const SugarLevelCircle({
    Key? key,
    required this.sugarLevel,
    this.color = Colors.blue,
    this.size = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: size / 2,
      child: Text(
        sugarLevel.toString(),
        style: TextStyle(
          fontSize: size / 2,
          color: Colors.white,
        ),
      ),
    );
  }
}
