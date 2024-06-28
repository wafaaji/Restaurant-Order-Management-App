import 'package:employee/components/customIconButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGridRemovedItem extends StatelessWidget {

  final String imagePath;
  final String text;
  final VoidCallback restoreOnPressed;

  CustomGridRemovedItem({required this.imagePath, required this.text, required this.restoreOnPressed});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
      footer: GridTileBar(
        title: Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
        trailing: CustomIconButton(
          icon: Icons.restore_from_trash_rounded,
          color: Colors.white,
          size: 20.0,
          onPressed: () {
            restoreOnPressed();
          },
        ),
      ),
    );
  }
}
