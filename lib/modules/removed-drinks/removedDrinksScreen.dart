import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customGridMainItem.dart';
import 'package:employee/components/customGridMenuItem.dart';
import 'package:employee/components/customGridRemovedItem.dart';
import 'package:employee/components/customSubCategory.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/menu-meals/menuMealsController.dart';
import 'package:employee/modules/removed-drinks/removedDrinksController.dart';
import 'package:employee/modules/removed-meals/removedMealsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class removedDrinksScreen extends GetView<RemovedDrinksController> {


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
                      controller.removedDrinksController.animateTo(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.removedDrinksController,
                  children: List<Widget>.generate(
                    controller.drinkCategories.length + 1,
                        (index) {
                      if (index == 0) {
                        final allRemovedDrinksList = controller.removedDrinksList.toList();
                        return RefreshIndicator(
                          onRefresh: controller.fetchData,
                          color: Color(0xFFBE0B0B),
                          child: CustomTabContent(drinksList: allRemovedDrinksList, onRestorePressed: onClickRestoreRemovedDrink),);
                      } else {
                        final category = controller.drinkCategories[index - 1];
                        final removedDrinksList = controller.removedDrinksList
                            .where((drink) => drink.categoryId == category.id)
                            .toList();
                        return RefreshIndicator(
                          onRefresh: controller.fetchData,
                          color: Color(0xFFBE0B0B),
                          child: CustomTabContent(drinksList: removedDrinksList, onRestorePressed: onClickRestoreRemovedDrink),);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
      ),
    );
  }
  void onClickRestoreRemovedDrink(MealsDrinks mealsDrinks) async{
    EasyLoading.show(status: "loading...");

    await controller.restoreRemovedDrinkOnClick(mealsDrinks);

    if(controller.restoreRemovedDrinkStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/mealsDrinks");
      await controller.updateRemovedDrinkList();
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
  final Function(MealsDrinks) onRestorePressed;

  CustomTabContent({required this.drinksList, required this.onRestorePressed});

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
            final removedDrinks = drinksList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed("/mealDetails", arguments: removedDrinks);
              },
              child: CustomGridRemovedItem(
                imagePath: removedDrinks.image,
                text: removedDrinks.name,
                restoreOnPressed: () { onRestorePressed(removedDrinks); },
              ),
            );
          },
        ),
      ),
    );
  }

}