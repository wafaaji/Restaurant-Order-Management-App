import 'package:employee/components/customIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGridCategory extends StatelessWidget {

  final String title;
  final String subTitle;
  final VoidCallback editOnPressed;
  final VoidCallback deleteOnPressed;

  CustomGridCategory({
    required this.title,
    required this.subTitle,
    required this.editOnPressed,
    required this.deleteOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container( decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
      footer: GridTileBar(
        title: Text(
            subTitle,
            style: GoogleFonts.lato(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        backgroundColor: Colors.black54,
        leading: CustomIconButton(
          icon: Icons.edit,
          color: Colors.white,
          size: 20.0,
          onPressed: editOnPressed,
        ),
        trailing: CustomIconButton(
          icon: Icons.delete,
          color: Colors.white,
          size: 20.0,
          onPressed: deleteOnPressed,
        ),
      ),
    );
  }
}
