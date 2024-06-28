import 'dart:io';
import 'package:employee/components/customBottomSheetPictureSelect.dart';
import 'package:employee/components/customDropdownButton.dart';
import 'package:employee/components/customRowButton.dart';
import 'package:employee/components/customTextField.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/edit-meal-drink/editDrinkController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class editDrinkScreen extends GetView<EditDrinkController>{

  @override
  Widget build(BuildContext context) {

    MealsDrinks mealsDrinks = Get.arguments as MealsDrinks;

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
              key: controller.editDrinksFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children:[
                        Obx(() =>
                            CircleAvatar(
                              backgroundColor: Color(0xFFBE0B0B),
                              radius: 100,
                              backgroundImage: controller.imagePath.isNotEmpty
                                  ? FileImage(File(controller.imagePath.value)) as ImageProvider
                                  : NetworkImage(mealsDrinks.image),
                            ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 140,
                          child: InkWell(
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.white,
                              ),
                              child:Icon(Icons.local_see,
                                color: Colors.black,
                              ),
                            ),
                            onTap: (){
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
                          ),
                        ),
                      ],
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
                      defaultText: mealsDrinks.name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                      defaultText: mealsDrinks.price.toString(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Obx( ()=> CustomDropdownButton(
                      hint: 'Category',
                      onChanged: (newValue) {
                        controller.setSelectedCategory(newValue!);
                      },
                      value: controller.selectedCategory.value.name,
                      items: controller.drinkCategories.map((category) => category.name).toList(),
                      width: 250.0,
                    ),),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                      controller: controller.detailsController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        controller.details = value!;
                      },
                      defaultText: mealsDrinks.description,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: CustomRowButton(
                        buttonLeftText: 'Cancle',
                        buttonRightText: 'Edit',
                        onLeftPressed: () {
                          Get.toNamed("/mealsDrinks");
                        },
                        onRightPressed: (){
                          onClickEditMealsDrink(mealsDrinks);
                        },
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

  void onClickEditMealsDrink(MealsDrinks mealsDrinks) async{
    EasyLoading.show(status: "loading...");

    await controller.editCategoryOnClick(mealsDrinks);

    if(controller.editMainMealStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/category");
      //await controller.updateMainMealsList();
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
