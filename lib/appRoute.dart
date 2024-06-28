import 'package:employee/modules/acctive-offers/activeOffersScreen.dart';
import 'package:employee/modules/add-meal-drinks/addDrinkScreen.dart';
import 'package:employee/modules/add-meal-drinks/addMealScreen.dart';
import 'package:employee/modules/add-offer-order/addOfferOrderScreen.dart';
import 'package:employee/modules/all-offers/allOffersScreen.dart';
import 'package:employee/modules/category/categoryScreen.dart';
import 'package:employee/modules/edit-meal-drink/editDrinkScreen.dart';
import 'package:employee/modules/edit-meal-drink/editMealScreen.dart';
import 'package:employee/modules/home/homeScreen.dart';
import 'package:employee/modules/login/loginScreen.dart';
import 'package:employee/modules/main-drinks/mainDrinksScreen.dart';
import 'package:employee/modules/main-meals/mainMealsScreen.dart';
import 'package:employee/modules/meals-drinks-details/drinkDetailsScreen.dart';
import 'package:employee/modules/meals-drinks-details/mealDetailsScreen.dart';
import 'package:employee/modules/meals-drinks/mealsDrinksScreen.dart';
import 'package:employee/modules/menu-drinks/menuDrinksScreen.dart';
import 'package:employee/modules/menu-meals/menuMealsScreen.dart';
import 'package:employee/modules/offer-order-details/offerOrderDetailsScreen.dart';
import 'package:employee/modules/offers/offersScreen.dart';
import 'package:employee/modules/orderDetails/orderDetailsScreen.dart';
import 'package:employee/modules/orders/ordersScreen.dart';
import 'package:employee/modules/removed-drinks/removedDrinksScreen.dart';
import 'package:employee/modules/removed-meals/removedMealsScreen.dart';
import 'package:employee/modules/reservation/reservationScreen.dart';
import 'package:employee/modules/select-meals-drinks/selectMealsDrinksScreen.dart';
import 'package:employee/modules/splash/splashScreen.dart';
import 'package:employee/modules/tables/tablesScreen.dart';
import 'package:employee/modules/the-reservation/theReservationScreen.dart';
import 'package:employee/modules/unactive-offers/unactiveOffersScreen.dart';
import 'package:employee/modules/waiting-orders/waitingOrdersScreen.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(name: '/login', page: () => loginScreen()),
  GetPage(name: '/splash', page: () => splashScreen()),
  GetPage(name: '/home', page: () => homeScreen()),
  GetPage(name: '/reservation', page: () => reservationScreen()),
  GetPage(name: '/category', page: () => categoryScreen()),
  GetPage(name: '/offers', page: () => offersScreen()),
  GetPage(name: '/offerOrderDetails', page: () => offerOrderDetailsScreen()),
  GetPage(name: '/addOfferOrder', page: () => addOfferOrderScreen()),
  GetPage(name: '/mealsDrinks', page: () => mealsDrinksScreen()),
  GetPage(name: '/mainMeals', page: () => mainMealsScreen()),
  GetPage(name: '/mealDetails', page: () => mealDetailsScreen()),
  GetPage(name: '/drinkDetails', page: () => drinkDetailsScreen()),
  GetPage(name: '/mainDrinks', page: () => mainDrinksScreen()),
  GetPage(name: '/menuMeals', page: () => menuMealsScreen()),
  GetPage(name: '/menuDrinks', page: () => menuDrinksScreen()),
  GetPage(name: '/removedMeals', page: () => removedMealsScreen()),
  GetPage(name: '/removedDrinks', page: () => removedDrinksScreen()),
  GetPage(name: '/addMeal', page: () => addMealScreen()),
  GetPage(name: '/addDrink', page: () => addDrinkScreen()),
  GetPage(name: '/editMeal', page: () => editMealScreen()),
  GetPage(name: '/editDrink', page: () => editDrinkScreen()),
  GetPage(name: '/tables', page: () => tablesScreen()),
  GetPage(name: '/orders', page: () => ordersScreen()),
  GetPage(name: '/waiting-orders', page: () => waitingOrdersScreen()),
  GetPage(name: '/selectMealsDrinks', page: () => selectMealsDrinksScreen()),
  GetPage(name: '/orderDetails', page: () => orderDetailsScreen()),
  GetPage(name: '/theReservation', page: () => theReservationScreen()),
  GetPage(name: '/allOffers', page: () => allOffersScreen()),
  GetPage(name: '/activeOffers', page: () => activeOffersScreen()),
  GetPage(name: '/unActiveOffers', page: () => unActiveOffersScreen()),

];
