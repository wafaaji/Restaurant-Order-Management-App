import 'package:employee/components/customElevatedButton.dart';
import 'package:flutter/material.dart';

class CustomRowButton extends StatelessWidget {
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final String buttonLeftText;
  final String buttonRightText;

  CustomRowButton({
    required this.onLeftPressed,
    required this.onRightPressed,
    required this.buttonLeftText,
    required this.buttonRightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomElevatedButton(
              onPressed: onLeftPressed,
              buttonText: buttonLeftText,
              buttonColor: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(20),
              height: 40.0,
              fontSize: 15.0,
              textColor: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: CustomElevatedButton(
              onPressed: onRightPressed,
              buttonText: buttonRightText,
              buttonColor: Color(0xFFBE0B0B),
              borderRadius: BorderRadius.circular(20),
              height: 40.0,
              fontSize: 15.0,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
