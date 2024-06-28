import 'package:employee/model/acceptRejectOrderModel.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/modules/waiting-orders/acceptRejectOrderService.dart';
import 'package:employee/modules/waiting-orders/displayOrdersService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class WaitingOrderController extends GetxController{

  var message;

  //for display waiting-orders
  late DisplayOrdersService serviceDisplay;
  var orderList = <Orders>[].obs;
  late List<Orders> allOrders= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();

  // for accept or reject waiting-orders
  late AcceptRejectOrderService serviceAcceptRejectOrder;
  var acceptRejectOrderStatus;


  @override
  void onInit() {
    serviceDisplay = DisplayOrdersService();
    serviceAcceptRejectOrder = AcceptRejectOrderService();
    acceptRejectOrderStatus = false;
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

  Future<void> acceptRejectOrderOnClick(Orders orders, int status) async{
    AcceptRejectOrder acceptRejectOrder = AcceptRejectOrder(
        id: orders.id,
        status: status,
    );
    acceptRejectOrderStatus = await serviceAcceptRejectOrder.acceptRejectOrder(acceptRejectOrder);
    message = serviceAcceptRejectOrder.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateAcceptRejectOrdersList() async {
    isLoading.value = true;
    orderList.clear();

    // Fetch the new list of menu drinks based on the existing categories
    var token = await storage.read("token");
    allOrders = await serviceDisplay.displayOrders(token);
    orderList.value = allOrders;

    isLoading.value = false;
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