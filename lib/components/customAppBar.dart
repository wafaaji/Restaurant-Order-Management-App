import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:employee/components/customIconButton.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Function? onPressed;
  final bool showTabBar;
  final TabController? controller;
  final List<Widget>? tabs;

  const CustomAppBar({
    required this.title,
    this.onPressed,
    this.showTabBar = false,
    this.controller,
    this.tabs,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFBE0B0B),
      leading: CustomIconButton(
          icon: Icons.arrow_back_outlined,
          color: Colors.white,
          size: 25.0,
         onPressed: () {
          if (onPressed != null) {
          onPressed!(); // Invoke the callback if provided
          }
        },
        ),
      title: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 25,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      bottom: showTabBar
          ? TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 4.0,
              labelStyle: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              controller: controller,
              tabs: tabs!,
          ) : null,
    );
  }
}
