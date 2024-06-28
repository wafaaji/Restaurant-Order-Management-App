import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController with SingleGetTickerProviderMixin{
  late TabController waitingController;

  final List<Tab> waitingTabs = <Tab>[
    Tab(
      text: "Waiting Orders",
    ),
    Tab(
      text: "Accept Orders",
    ),
    Tab(
      text: "Reject Orders",
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
