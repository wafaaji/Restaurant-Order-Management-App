import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersController extends GetxController with SingleGetTickerProviderMixin{
  late TabController offersController;

  final List<Tab> offersTabs = <Tab>[
    Tab(
      text: "All Offers",
    ),
    Tab(
      text: "Active Offers",
    ),
    Tab(
      text: "UnActive Offers",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    offersController = TabController(length: offersTabs.length, vsync: this);
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose() {
    offersController.dispose();
    super.onClose();
  }
}
