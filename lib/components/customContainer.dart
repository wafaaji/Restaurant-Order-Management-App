import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  final IconData iconData;
  final String text;
  final double height;
  final int maxLines;
  final EdgeInsets margin;

  const CustomContainer({
    required this.iconData,
    required this.text,
    this.height = 50.0,
    this.maxLines = 1,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.only(left: 20.0),
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 25,
            color: Colors.black,
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
              maxLines: maxLines,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
