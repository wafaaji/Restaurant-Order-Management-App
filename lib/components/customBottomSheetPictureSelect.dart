import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomSheetPictureSelect extends StatelessWidget {
  final double deviceHeight;
  final double deviceWidth;
  final VoidCallback galleryOnTap;
  final VoidCallback cameraOnTap;

  CustomBottomSheetPictureSelect({
    required this.deviceHeight,
    required this.deviceWidth,
    required this.galleryOnTap,
    required this.cameraOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.3,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose Image",
            style: GoogleFonts.lato(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFBE0B0B),
                              width: 1.2,
                            ),
                          ),
                          child: Icon(
                            Icons.image,
                            color: Color(0xFFBE0B0B),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Gallery',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    onTap: galleryOnTap,
                  ),
              SizedBox(
                width: 100.0,
              ),
              InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFBE0B0B),
                          width: 1.2,
                        ),
                      ),
                      child: Icon(
                        Icons.camera,
                        color: Color(0xFFBE0B0B),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Camera',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                onTap: cameraOnTap
              ),
            ],
          ),
        ],
      ),
    );
  }
}
