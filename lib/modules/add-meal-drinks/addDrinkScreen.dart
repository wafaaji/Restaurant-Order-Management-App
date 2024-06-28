import 'dart:io';
import 'package:employee/components/customBottomSheetPictureSelect.dart';
import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customTextField.dart';
import 'package:employee/modules/add-meal-drinks/addDrinkController.dart';
import 'package:employee/modules/main-drinks/mainDrinksController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class addDrinkScreen extends GetView<AddDrinkController>{

  @override
  Widget build(BuildContext context) {

    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: controller.addDrinkFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx( () => CircleAvatar(
                      backgroundColor: Color(0xFFBE0B0B),
                      radius: 100,
                      backgroundImage: controller.imagePath.isNotEmpty
                          ? FileImage(File(controller.imagePath.value)) as ImageProvider
                          : AssetImage("assets/Drinks.jpg"),
                    ),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                          ),
                          barrierColor: Colors.black.withOpacity(0.5),
                          showDragHandle: true,
                          context: context,
                          builder: (BuildContext context ) {
                            return CustomBottomSheetPictureSelect(
                              deviceHeight: deviceHeight * 1,
                              deviceWidth: deviceWidth,
                              galleryOnTap: () {
                                controller.pickImageGallery();
                              },
                              cameraOnTap: () {
                                controller.pickImageCamera();
                              },
                            );
                          },
                        );
                      },
                      buttonText: 'Pick Image',
                      buttonColor: Color(0xFFBE0B0B),
                      borderRadius: BorderRadius.circular(20),
                      height: 30.0,
                      fontSize: 15.0,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        controller.name = value!;
                      },
                      validator: (value) {
                        return controller.validateEmptyName(value!);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        controller.price = value!;
                      },
                      validator: (value) {
                        return controller.validateEmptyPrice(value!);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Price",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Obx (() => DropdownButton<String>(
                      value: controller.selectCategory.value,
                      onChanged: (newValue) {
                        controller.setSelectedCategory(newValue!);
                      },
                      items: controller.drinkCategories.map<DropdownMenuItem<String>>((category) {
                        return DropdownMenuItem<String>(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                    )
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: controller.detailsController,
                      keyboardType: TextInputType.multiline,
                      //textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        controller.details = value!;
                      },
                      validator: (value) {
                        return controller.validateEmptyDescription(value!);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  Get.toNamed("/mealsDrink");
                                },
                                buttonText: 'Cancle',
                                buttonColor: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(20),
                                height: 30.0,
                                fontSize: 15.0,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  onClickAddDrink();
                                },
                                buttonText: 'Add',
                                buttonColor: Color(0xFFBE0B0B),
                                borderRadius: BorderRadius.circular(20),
                                height: 30.0,
                                fontSize: 15.0,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClickAddDrink() async{
    EasyLoading.show(status: "loading...");

    await controller.addDrinkOnClick();

    if(controller.addDrinkStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 3),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );

      //
      // Call the updateMainMealList function to update main drinks list
      Get.find<MainDrinksController>().updateMainDrinkList();
      //

      Get.toNamed("/mealsDrinks");
    }else{
      EasyLoading.showError(
        controller.message,
        duration: Duration(seconds: 3),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      print("Error Here");
    }
  }

}
