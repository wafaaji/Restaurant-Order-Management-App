import 'package:employee/components/customIconButton.dart';
import 'package:employee/modules/reservation/reservationScreen.dart';
import 'package:employee/modules/the-reservation/theReservationController.dart';
import 'package:employee/modules/waiting-reservation/waitingReservationScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class theReservationScreen extends GetView<TheReservationController> {

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
        title:  Text(
          "The Reservation",
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        bottom: TabBar(
          //isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelStyle: GoogleFonts.lato(
            fontSize: 15,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
          controller: controller.waitingController,
          tabs: controller.waitingTabs,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: controller.waitingController,
              children: [
                reservationScreen(),
                waitingReservationScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
