import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customGridMainItem.dart';
import 'package:employee/components/customSubCategory.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/main-drinks/mainDrinksController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class mainDrinksScreen extends GetView<MainDrinksController> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
        }
        return DefaultTabController(
          length: controller.drinkCategories.length + 1,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 65.0,
                  width: double.infinity,
                  child: CustomSubCategory(
                    items: ["All"] + controller.drinkCategories
                        .map((category) => category.name)
                        .toList(),
                    current: controller.current,
                    onTap: (index) {
                      controller.current.value = index;
                      controller.mainDrinksController.animateTo(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.mainDrinksController,
                  children: List<Widget>.generate(
                    controller.drinkCategories.length + 1,
                        (index) {
                      if (index == 0) {
                        final allMainDrinksList = controller.mainDrinksList.toList();
                        return RefreshIndicator(
                          onRefresh: controller.fetchData,
                          color: Color(0xFFBE0B0B),
                          child: CustomTabContent(drinksList: allMainDrinksList, onDeletePressed: onClickDeleteMainDrink),);
                      } else {
                        final category = controller.drinkCategories[index - 1];
                        final mainDrinksList = controller.mainDrinksList
                            .where((drink) => drink.categoryId == category.id)
                            .toList();
                        return RefreshIndicator(
                          onRefresh: controller.fetchData,
                          color: Color(0xFFBE0B0B),
                          child: CustomTabContent(drinksList: mainDrinksList, onDeletePressed: onClickDeleteMainDrink),);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: CustomElevatedButton(
                  onPressed: () {
                    Get.toNamed("/addDrink");
                  },
                  buttonText: "Add Drink",
                  height: 40.0,
                  buttonColor: Color(0xFFBE0B0B),
                  borderRadius: BorderRadius.circular(20),
                  textColor: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        );
      }
      ),
    );
  }
  void onClickDeleteMainDrink(MealsDrinks mealsDrinks) async{
    EasyLoading.show(status: "loading...");

    await controller.deleteMainDrinkOnClick(mealsDrinks);

    if(controller.deleteMainDrinkStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/mealsDrinks");
      await controller.updateMainDrinkList();
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

class CustomTabContent extends StatelessWidget {
  final List<MealsDrinks> drinksList;
  final Function(MealsDrinks) onDeletePressed;

  CustomTabContent({required this.drinksList, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFBE0B0B),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
        child: GridView.builder(
          itemCount: drinksList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3,
            mainAxisExtent: 120,
          ),
          itemBuilder: (context, index) {
            final mealsDrinks = drinksList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed("/drinkDetails", arguments: mealsDrinks);
              },
              child: CustomGridMainItem(
                imagePath: mealsDrinks.image,
                text: mealsDrinks.name,
                editOnPressed: () {
                  Get.toNamed("/editDrink", arguments: mealsDrinks);
                },
                deleteOnPressed: () { onDeletePressed(mealsDrinks); },
              ),
            );
          },
        ),
      ),
    );
  }

}