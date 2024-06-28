import 'package:employee/model/offersModel.dart';
import 'package:employee/model/setUnActiveOfferModel.dart';
import 'package:employee/modules/acctive-offers/displayActiveOffersService.dart';
import 'package:employee/modules/acctive-offers/setUnActiveOfferService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ActiveOffersController extends GetxController{

  var message;

  //for display offers
  late DisplayActiveOffersService serviceDisplay;
  var offersList = <Offers>[].obs;
  late List<Offers> allOffers= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();

  // for set unactive offer
  late SetUnActiveOfferService serviceUnActive;
  var setUnActiveOfferStatus;



  @override
  void onInit() {
    serviceDisplay = DisplayActiveOffersService();

    serviceUnActive = SetUnActiveOfferService();
    setUnActiveOfferStatus = false;

    super.onInit();
  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allOffers = await serviceDisplay.displayActiveOffers(token);
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
    allOffers = await serviceDisplay.displayActiveOffers(token);
    offersList.value = allOffers;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

  Future<void> setUnActiveOfferOnClick(Offers offers) async{
    SetUnActiveOffer setUnActiveOffer = SetUnActiveOffer(
      id: offers.id,
    );
    setUnActiveOfferStatus = await serviceUnActive.setUnActiveOffer(setUnActiveOffer);
    message = serviceUnActive.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateMainDrinkList() async {
    isLoading.value = true;
    offersList.clear();

    var token = await storage.read("token");
    allOffers = await serviceDisplay.displayActiveOffers(token);
    offersList.value = allOffers;

    isLoading.value = false;
  }


}