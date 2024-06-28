import 'dart:ffi';

import 'package:employee/components/customAppBar.dart';
import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customRowButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/components/customTextField.dart';
import 'package:employee/modules/add-offer-order/addOfferOrderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class addOfferOrderScreen extends GetView<AddOfferOrderController> {


  @override
  Widget build(BuildContext context) {

    List<String> selectedMeals = Get.arguments?["selectedMeals"] ?? [];
    List<String> selectedDrinks = Get.arguments?["selectedDrinks"] ?? [];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Order Offer',
        onPressed: (){
          Get.toNamed("/offers");
        },
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Form(
              key: controller.addOfferOrderFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Select Order Offer Components",
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: CustomElevatedButton(
                      onPressed: () {
                        Get.toNamed("/selectMealsDrinks");
                      },
                      buttonText: 'Select Components',
                      buttonColor: Color(0xFFBE0B0B),
                      borderRadius: BorderRadius.circular(20),
                      height: 40.0,
                      fontSize: 15.0,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  CustomText(
                    text: "the number of selected:  ${selectedMeals + selectedDrinks}",
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomText(
                    text: "Select order offer end date",
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 175.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Obx(() => Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                          child:CustomText(
                            text: 'Selected Date: \n ${controller.selectedDate.value.year} / ${controller.selectedDate.value.month} / ${controller.selectedDate.value.day}',
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          ),
                        ),
                        ),
                      CustomElevatedButton(
                        onPressed: () => controller.selectDate(context),
                        buttonText: 'Select Date',
                        buttonColor: Color(0xFFBE0B0B),
                        borderRadius: BorderRadius.circular(20),
                        height: 40.0,
                        fontSize: 15.0,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    controller: controller.newPriceController,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      controller.newPrice = value!;
                    },
                    validator: (value) {
                      controller.validateEmptyNewPrice(value!);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New Price",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    controller: controller.descriptionController,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      controller.description = value!;
                    },
                    validator: (value) {
                      controller.validateEmptyDescription(value!);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Description",
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 50.0),
                    child: CustomRowButton(
                      onLeftPressed: () {
                        Get.toNamed("/offers");
                      },
                      onRightPressed: () {
                        onClickAddOffer();
                      },
                      buttonLeftText: "Cancle",
                      buttonRightText: 'Add',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClickAddOffer() async{
    EasyLoading.show(status: "loading...");

    await controller.addOffersOnClick();

    if(controller.addOffersStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );

      Get.toNamed("/offers");
    }else{
      EasyLoading.showError(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      print("Error Here");
    }
  }

}
