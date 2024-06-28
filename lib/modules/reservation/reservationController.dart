import 'package:employee/model/acceptRejectReservationModel.dart';
import 'package:employee/model/reservationModel.dart';
import 'package:employee/modules/reservation/acceptRejectReservationService.dart';
import 'package:employee/modules/reservation/displayReservationService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get.dart';

class ReservationController extends GetxController {

  var message;

  //for display reservation
  late DisplayReservationService serviceDisplay;
  var reservationList = <Reservation>[].obs;
  late List<Reservation> allReservation= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();

  // for accept or reject reservation
  late AcceptRejectReservationService serviceAcceptRejectReservation;
  var acceptRejectReservationStatus;


  @override
  void onInit() {

    serviceDisplay = DisplayReservationService();
    serviceAcceptRejectReservation = AcceptRejectReservationService();
    acceptRejectReservationStatus = false;
    super.onInit();
  }

  @override
  void onReady() async{

    var token = await storage.read("token");
    allReservation = await serviceDisplay.displayReservation(token);
    reservationList.value = allReservation;
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> acceptRejectReservationOnClick(Reservation reservation, int status) async{
    AcceptRejectReservation acceptRejectReservation = AcceptRejectReservation(
      id: reservation.id,
      status: status,
    );
    acceptRejectReservationStatus = await serviceAcceptRejectReservation.acceptRejectReservation(acceptRejectReservation);
    message = serviceAcceptRejectReservation.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateAcceptRejectReservationList() async {
    isLoading.value = true;
    reservationList.clear();

    // Fetch the new list of Reservation based on the existing categories
    var token = await storage.read("token");
    allReservation = await serviceDisplay.displayReservation(token);
    reservationList.value = allReservation;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allReservation = await serviceDisplay.displayReservation(token);
    reservationList.value = allReservation;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
