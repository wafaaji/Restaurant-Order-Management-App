import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;

  const CustomCircleAvatar({
    required this.imagePath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CircleAvatar(
        backgroundColor:  Color(0xFFBE0B0B),
        backgroundImage: AssetImage(imagePath),
        radius: radius,
      ),
    );
  }
}
