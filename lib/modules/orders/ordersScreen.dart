import 'package:employee/components/customIconButton.dart';
import 'package:employee/modules/accept-orders/acceptOrdersScreen.dart';
import 'package:employee/modules/orders/ordersController.dart';
import 'package:employee/modules/reject-orders/rejectOrdersScreen.dart';
import 'package:employee/modules/waiting-orders/waitingOrdersScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ordersScreen extends GetView<OrdersController> {

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
          "Orders",
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
                waitingOrdersScreen(),
                acceptOrdersScreen(),
                rejectOrdersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
