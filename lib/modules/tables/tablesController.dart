import 'package:employee/model/openCloseTablesModel.dart';
import 'package:employee/model/tablesModel.dart';
import 'package:employee/modules/tables/displayTablesService.dart';
import 'package:employee/modules/tables/openCloseTablesService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get.dart';

class TablesController extends GetxController {

  var message;

  //for display Tables
  late DisplayTablesService serviceDisplay;
  var tablesList = <Tables>[].obs;
  late List<Tables> allTables= [];
  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();

  // for accept or reject reservation
  late OpenCloseTableService serviceOpenCloseTable;
  var openCloseTableStatus;


  @override
  void onInit() {

    serviceDisplay = DisplayTablesService();
    serviceOpenCloseTable = OpenCloseTableService();
    openCloseTableStatus = false;
    super.onInit();
  }

  @override
  void onReady() async{

    var token = await storage.read("token");
    allTables = await serviceDisplay.displayTables(token);
    tablesList.value = allTables;
    isLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> OpenCloseTableOnClick(Tables tables, int status) async{
    OpenCloseTable openCloseTable = OpenCloseTable(
      id: tables.id,
      status: status,
    );
    openCloseTableStatus = await serviceOpenCloseTable.openCloseTable(openCloseTable);
    message = serviceOpenCloseTable.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  Future<void> updateOpenCloseTableList() async {
    isLoading.value = true;
    tablesList.clear();

    // Fetch the new list of Tables based on the existing categories
    var token = await storage.read("token");
    allTables = await serviceDisplay.displayTables(token);
    tablesList.value = allTables;

    isLoading.value = false;
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allTables = await serviceDisplay.displayTables(token);
    tablesList.value = allTables;
    isLoading.value = false;

    await Future.delayed(Duration(seconds: 0)); // Simulate loading
    isLoading.value = false;
  }

}
