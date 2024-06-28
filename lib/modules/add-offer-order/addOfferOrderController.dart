import 'package:employee/model/addOffersModel.dart';
import 'package:employee/modules/add-offer-order/addOfferService.dart';
import 'package:employee/modules/select-meals-drinks/selectMealsDrinksController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';


class AddOfferOrderController extends GetxController {


  final addOfferOrderFormKey = GlobalKey<FormState>();
  late TextEditingController descriptionController, newPriceController;
  var description;
  var newPrice;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  // for add offer
  late AddOffersService serviceAdd;
  var addOffersStatus;
  var message;


  @override
  void onInit(){

    print("Arguments: ${Get.arguments}");
    newPriceController = TextEditingController();
    descriptionController = TextEditingController();

    newPrice = '';
    description= '';

    serviceAdd = AddOffersService();
    addOffersStatus = false;
    message = '';

    super.onInit() ;
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();

    newPriceController.dispose();
    descriptionController.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select A Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
      locale: Locale('en', 'US'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFFBE0B0B),
            colorScheme: ColorScheme.light(primary: Color(0xFFBE0B0B),),
          ),  child: child!,
        );
      },
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.day,
      fieldLabelText: 'Select a date',
      fieldHintText: 'MM/DD/YYYY',
      errorFormatText: 'Invalid date format',
      errorInvalidText: 'Invalid date',
      useRootNavigator: true,
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> addOffersOnClick() async{
    EasyLoading.show(status: "loading...");

    final List<String> selectedMeals = Get.find<SelectMealsDrinksController>().getSelectedMealIds();
    final List<String> selectedDrinks = Get.find<SelectMealsDrinksController>().getSelectedDrinkIds();


    AddOffers addOffers = AddOffers(
      newPrice: newPriceController.text,
      description: descriptionController.toString(),
      expirateDate: selectedDate.value,
      mealeIds: [...selectedMeals, ...selectedDrinks],
    );
    addOffersStatus = await serviceAdd.addOffers(addOffers);
    message = serviceAdd.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  String? validateEmptyNewPrice (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add new Price';
    }
    return null;
  }

  String? validateEmptyDescription (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add description';
    }
    return null;
  }


}
