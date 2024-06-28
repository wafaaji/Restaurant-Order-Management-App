import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubCategory extends StatelessWidget {
  final List<String> items;
  final RxInt current;
  final Function? onTap;

  CustomSubCategory({
    required this.items,
    required this.current,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        return Obx(() => GestureDetector(
          onTap: () {
            current.value = index;
            onTap!(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.all(5),
            width: 80,
            height: 45,
            decoration: BoxDecoration(
              color: current.value == index
                  ? Colors.black38
                  : Color(0xFFD9D9D9),
              borderRadius: current.value == index
                  ? BorderRadius.circular(15)
                  : BorderRadius.circular(10),
              border: current.value == index
                  ? Border.all(color: Color(0xFFBE0B0B), width: 3)
                  : null,
            ),
            child: Center(
              child: Text(
                items[index],
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Color(0xFFBE0B0B),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
