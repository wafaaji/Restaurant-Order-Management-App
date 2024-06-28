import 'package:employee/components/customIconButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/modules/acctive-offers/activeOffersScreen.dart';
import 'package:employee/modules/all-offers/allOffersScreen.dart';
import 'package:employee/modules/offers/offersController.dart';
import 'package:employee/modules/unactive-offers/unactiveOffersScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class offersScreen extends GetView<OffersController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBE0B0B),
        leading: CustomIconButton(
          icon: Icons.arrow_back_outlined,
          color: Colors.white,
          size: 25.0,
          onPressed: () {
            Get.toNamed("/home");
          },
        ),
        title: CustomText(
          text: "Offers",
          fontSize: 25.0,
          color: Colors.white,
        ),
        bottom: TabBar(
          isScrollable: false,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          labelStyle: GoogleFonts.lato(
            fontSize: 15,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
          controller: controller.offersController,
          tabs: controller.offersTabs,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: controller.offersController,
              children: [
                allOffersScreen(),
                activeOffersScreen(),
                unActiveOffersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
