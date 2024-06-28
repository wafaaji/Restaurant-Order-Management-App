import 'package:employee/appRoute.dart';
import 'package:employee/bindings/allBindings.dart';
import 'package:employee/modules/add-offer-order/addOfferOrderScreen.dart';
import 'package:employee/modules/category/categoryScreen.dart';
import 'package:employee/modules/home/homeScreen.dart';
import 'package:employee/modules/login/loginScreen.dart';
import 'package:employee/modules/meals-drinks-details/mealDetailsScreen.dart';
import 'package:employee/modules/meals-drinks/mealsDrinksScreen.dart';
import 'package:employee/modules/offer-order-details/offerOrderDetailsScreen.dart';
import 'package:employee/modules/offers/offersScreen.dart';
import 'package:employee/modules/orderDetails/orderDetailsScreen.dart';
import 'package:employee/modules/orders/ordersScreen.dart';
import 'package:employee/modules/reservation/reservationScreen.dart';
import 'package:employee/modules/select-meals-drinks/selectMealsDrinksScreen.dart';
import 'package:employee/modules/splash/splashScreen.dart';
import 'package:employee/modules/tables/tablesScreen.dart';
import 'package:employee/modules/the-reservation/theReservationScreen.dart';
import 'package:employee/modules/waiting-orders/waitingOrdersScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: allBindings(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFBE0B0B),
      ),
      initialRoute: '/splash',
      getPages: appPages,
      //home: loginScreen(),
    );
  }
}
