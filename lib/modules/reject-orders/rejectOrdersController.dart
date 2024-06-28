import 'package:employee/model/acceptRejectOrderModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/modules/accept-orders/displayAcceptOrdersService.dart';
import 'package:employee/modules/reject-orders/displayRejectOrdersService.dart';
import 'package:employee/modules/waiting-orders/acceptRejectOrderService.dart';
import 'package:employee/modules/waiting-orders/displayOrdersService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class RejectOrderController extends GetxController{

  var message;

  //for display reject orders
  late DisplayRejectOrdersService serviceDisplay;
  var orderList = <Orders>[].obs;
  late List<Orders> allOrders= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();



  @override
  void onInit() {
    serviceDisplay = DisplayRejectOrdersService();
    super.onInit();
  }

  @override
  void onReady() async{
    var token = await storage.read("token");
    allOrders = await serviceDisplay.displayOrders(token);
    orderList.value = allOrders;
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
    allOrders = await serviceDisplay.displayOrders(token);
    orderList.value = allOrders;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }


}