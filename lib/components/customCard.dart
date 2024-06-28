import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String text;

  CustomCard({required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.black,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              imagePath,
               width: 140,
               height: 110,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 100.0,
            child: Container(
              color: Colors.white,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
