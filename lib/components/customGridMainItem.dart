import 'package:employee/components/customIconButton.dart';
import 'package:employee/modules/edit-meal-drink/editMealScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGridMainItem extends StatelessWidget {

  final String imagePath;
  final String text;
  final VoidCallback editOnPressed;
  final VoidCallback deleteOnPressed;

  CustomGridMainItem({required this.imagePath, required this.text, required this.editOnPressed, required this.deleteOnPressed});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imagePath),
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
        leading: CustomIconButton(
          icon: Icons.edit,
          color: Colors.white,
          size: 20.0,
          onPressed: () {
            editOnPressed();
          },
        ),
        trailing: CustomIconButton(
          icon: Icons.delete,
          color: Colors.white,
          size: 20.0,
          onPressed: () {
            deleteOnPressed();
          },
        ),
      ),
    );
  }
}
