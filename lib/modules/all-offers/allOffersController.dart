import 'package:employee/model/offersModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/modules/all-offers/displayAllOffersService.dart';
import 'package:employee/modules/reject-orders/displayRejectOrdersService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class AllOffersController extends GetxController{

  var message;

  //for display offers
  late DisplayAllOffersService serviceDisplay;
  var offersList = <Offers>[].obs;
  late List<Offers> allOffers= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();



  @override
  void onInit() {
    serviceDisplay = DisplayAllOffersService();
    super.onInit();
  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allOffers = await serviceDisplay.displayAllOffers(token);
    offersList.value = allOffers;
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allOffers = await serviceDisplay.displayAllOffers(token);
    offersList.value = allOffers;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }


}