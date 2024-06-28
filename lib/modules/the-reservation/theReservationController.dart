import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheReservationController extends GetxController with SingleGetTickerProviderMixin{
  late TabController waitingController;

  final List<Tab> waitingTabs = <Tab>[
    Tab(
      text: "Reservation",
    ),
    Tab(
      text: "Waiting Reservation",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    waitingController = TabController(length: waitingTabs.length, vsync: this);
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose() {
    waitingController.dispose();
    super.onClose();
  }
}
