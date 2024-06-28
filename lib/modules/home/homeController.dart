import 'dart:ui';
import 'package:employee/model/logoutModel.dart';
import 'package:employee/modules/home/logoutService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final List<String> titles = [
    "Tables",
    "Category",
    "Offers",
    "Meals/Drinks",
    "Orders",
    "Reservation",
  ];


  late LogoutService service;

  var logoutStatus;

  var message;

  late SecureStorage storage;

  @override
  void onInit() {
    service = LogoutService();
    logoutStatus = false;
    message = '';
    storage = SecureStorage();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final List<Widget> images = [
    Hero(tag: "Reservation", child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Reservation.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
      ),
    ),
    ),
    Hero(tag: "Category", child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Category.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
      ),
    ),
    ),
    Hero(tag: "Offers", child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Offers.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0), // Adjust the sigmaX and sigmaY values for desired blur effect
          child: Container(
            color: Colors.black.withOpacity(0), // Adjust the opacity value for desired clarity
          ),
        ),
      ),
    ),
    ),
    Hero(tag: "Meals/Drinks", child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Meals Drinks.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0), // Adjust the sigmaX and sigmaY values for desired blur effect
          child: Container(
            color: Colors.black.withOpacity(0), // Adjust the opacity value for desired clarity
          ),
        ),
      ),
    ),
    ),
    Hero(tag: "Tables", child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Tables.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0), // Adjust the sigmaX and sigmaY values for desired blur effect
          child: Container(
            color: Colors.black.withOpacity(0), // Adjust the opacity value for desired clarity
          ),
        ),
      ),
    ),
    ),
    Hero(tag: "Orders", child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Orders1.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0), // Adjust the sigmaX and sigmaY values for desired blur effect
          child: Container(
            color: Colors.black.withOpacity(0), // Adjust the opacity value for desired clarity
          ),
        ),
      ),
    ),
    ),
  ];

  final currentPage = 0.obs;

  void changePage(int page) {
    currentPage.value = page;
  }

  void selectCard(int index) {
    print('Card selected at index $index');

    if (index == 0) {
      Get.toNamed("/tables");
    } else if (index == 1) {
      Get.toNamed("/category");
    } else if (index == 2) {
      Get.toNamed("/offers");
    } else if (index == 3) {
      Get.toNamed("/mealsDrinks");
    } else if (index == 4) {
      Get.toNamed("/orders");
    } else if (index == 5) {
      Get.toNamed("/theReservation");
  }

  }

  Future<void> logoutOnClick() async{
    String? token = await storage.read("token");
    print("______________logout________________");
    print(token);
    logoutStatus = await service.logout(token);
    message = service.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

}
