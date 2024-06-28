import 'package:employee/model/acceptRejectReservationModel.dart';
import 'package:employee/model/reservationModel.dart';
import 'package:employee/model/setDoneReservationModel.dart';
import 'package:employee/modules/reservation/acceptRejectReservationService.dart';
import 'package:employee/modules/reservation/displayReservationService.dart';
import 'package:employee/modules/waiting-reservation/displayWaitingReservationService.dart';
import 'package:employee/modules/waiting-reservation/setDoneReservationService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get.dart';

class WaitingReservationController extends GetxController {

  var message;

  //for display reservation
  late DisplayWaitingReservationService serviceDisplay;
  var reservationList = <Reservation>[].obs;
  late List<Reservation> allReservation= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();

  // for accept or reject reservation
  late SetDoneReservationService serviceAcceptRejectReservation;
  var acceptRejectReservationStatus;


  @override
  void onInit() {

    serviceDisplay = DisplayWaitingReservationService();
    serviceAcceptRejectReservation = SetDoneReservationService();
    acceptRejectReservationStatus = false;
    super.onInit();
  }

  @override
  void onReady() async{

    var token = await storage.read("token");
    allReservation = await serviceDisplay.displayWaitingReservation(token);
    reservationList.value = allReservation;
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> acceptRejectReservationOnClick(Reservation reservation, int status) async{
    SetReservation setReservation = SetReservation(
      id: reservation.id,
    );
    acceptRejectReservationStatus = await serviceAcceptRejectReservation.setDoneReservation(setReservation);
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
    allReservation = await serviceDisplay.displayWaitingReservation(token);
    reservationList.value = allReservation;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allReservation = await serviceDisplay.displayWaitingReservation(token);
    reservationList.value = allReservation;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
