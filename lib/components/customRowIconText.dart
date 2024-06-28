import 'package:flutter/material.dart';
import 'package:employee/components/customText.dart';

class CustomRowIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomRowIconText({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
        ),
        SizedBox(
          width: 20.0,
        ),
        CustomText(
          text: text,
          fontSize: 20.0,
          color: Colors.black,
        ),
      ],
    );
  }
}
