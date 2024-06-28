import 'package:employee/modules/accept-orders/acceptOrdersController.dart';
import 'package:employee/modules/acctive-offers/acctiveOffersController.dart';
import 'package:employee/modules/add-meal-drinks/addDrinkController.dart';
import 'package:employee/modules/add-meal-drinks/addMealController.dart';
import 'package:employee/modules/add-offer-order/addOfferOrderController.dart';
import 'package:employee/modules/all-offers/allOffersController.dart';
import 'package:employee/modules/category/categoryController.dart';
import 'package:employee/modules/edit-meal-drink/editDrinkController.dart';
import 'package:employee/modules/edit-meal-drink/editMealController.dart';
import 'package:employee/modules/home/homeController.dart';
import 'package:employee/modules/login/loginController.dart';
import 'package:employee/modules/main-drinks/mainDrinksController.dart';
import 'package:employee/modules/main-meals/mainMealsController.dart';
import 'package:employee/modules/meals-drinks-details/drinkDetailsController.dart';
import 'package:employee/modules/meals-drinks-details/mealDetailsController.dart';
import 'package:employee/modules/meals-drinks/mealsDrinksController.dart';
import 'package:employee/modules/menu-drinks/menuDrinksController.dart';
import 'package:employee/modules/menu-meals/menuMealsController.dart';
import 'package:employee/modules/offers/offersController.dart';
import 'package:employee/modules/orders/ordersController.dart';
import 'package:employee/modules/reject-orders/rejectOrdersController.dart';
import 'package:employee/modules/removed-drinks/removedDrinksController.dart';
import 'package:employee/modules/removed-meals/removedMealsController.dart';
import 'package:employee/modules/reservation/reservationController.dart';
import 'package:employee/modules/select-meals-drinks/selectMealsDrinksController.dart';
import 'package:employee/modules/tables/tablesController.dart';
import 'package:employee/modules/the-reservation/theReservationController.dart';
import 'package:employee/modules/unactive-offers/unactiveOffersController.dart';
import 'package:employee/modules/waiting-orders/watingOrdersController.dart';
import 'package:employee/modules/waiting-reservation/waitingReservationController.dart';
import 'package:get/get.dart';

class allBindings extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MealsDrinksController());
    Get.lazyPut(() => MainMealsController());
    Get.lazyPut(() => MainDrinksController());
    Get.lazyPut(() => MenuMealsController());
    Get.lazyPut(() => MenuDrinksController());
    Get.lazyPut(() => RemovedMealsController());
    Get.lazyPut(() => RemovedDrinksController());
    Get.lazyPut(() => MealDetailsController());
    Get.lazyPut(() => DrinkDetailsController());
    Get.lazyPut(() => AddMealController());
    Get.lazyPut(() => AddDrinkController());
    Get.lazyPut(() => EditMealController());
    Get.lazyPut(() => EditDrinkController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => OffersController());
    Get.lazyPut(() => AddOfferOrderController());
    Get.lazyPut(() => OrdersController());
    Get.lazyPut(() => TablesController());
    Get.lazyPut(() => SelectMealsDrinksController());
    Get.lazyPut(() => WaitingOrderController());
    Get.lazyPut(() => AcceptOrderController());
    Get.lazyPut(() => RejectOrderController());
    Get.lazyPut(() => ReservationController());
    Get.lazyPut(() => TheReservationController());
    Get.lazyPut(() => AllOffersController());
    Get.lazyPut(() => ActiveOffersController());
    Get.lazyPut(() => UnActiveOffersController());
    Get.lazyPut(() => WaitingReservationController());

  }
}