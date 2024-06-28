import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customGridMainItem.dart';
import 'package:employee/components/customGridMenuItem.dart';
import 'package:employee/components/customGridRemovedItem.dart';
import 'package:employee/components/customSubCategory.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/menu-meals/menuMealsController.dart';
import 'package:employee/modules/removed-meals/removedMealsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class removedMealsScreen extends GetView<RemovedMealsController> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
        }
        return DefaultTabController(
          length: controller.mealCategories.length + 1,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 65.0,
                  width: double.infinity,
                  child: CustomSubCategory(
                    items: ["All"] + controller.mealCategories
                        .map((category) => category.name)
                        .toList(),
                    current: controller.current,
                    onTap: (index) {
                      controller.current.value = index;
                      controller.removedMealsController.animateTo(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.removedMealsController,
                  children: List<Widget>.generate(
                    controller.mealCategories.length + 1,
                        (index) {
                      if (index == 0) {
                        final allRemovedMealsList = controller.removedMealsList.toList();
                        return RefreshIndicator(
                          onRefresh: controller.fetchData,
                          color: Color(0xFFBE0B0B),
                          child: CustomTabContent(mealsList: allRemovedMealsList, onRestorePressed: onClickRestoreRemovedMeal),);
                      } else {
                        final category = controller.mealCategories[index - 1];
                        final removedMealsList = controller.removedMealsList
                            .where((meal) => meal.categoryId == category.id)
                            .toList();
                        return RefreshIndicator(
                          onRefresh: controller.fetchData,
                          color: Color(0xFFBE0B0B),
                          child: CustomTabContent(mealsList: removedMealsList, onRestorePressed: onClickRestoreRemovedMeal),);
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
  void onClickRestoreRemovedMeal(MealsDrinks mealsDrinks) async{
    EasyLoading.show(status: "loading...");

    await controller.restoreRemovedMealOnClick(mealsDrinks);

    if(controller.restoreRemovedMealStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/mealsDrinks");
      await controller.updateRemovedMealList();
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
  final List<MealsDrinks> mealsList;
  final Function(MealsDrinks) onRestorePressed;

  CustomTabContent({required this.mealsList, required this.onRestorePressed});

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
          itemCount: mealsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3,
            mainAxisExtent: 120,
          ),
          itemBuilder: (context, index) {
            final removedMeals = mealsList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed("/mealDetails", arguments: removedMeals);
              },
              child: CustomGridRemovedItem(
                imagePath: removedMeals.image,
                text: removedMeals.name,
                restoreOnPressed: () { onRestorePressed(removedMeals); },
              ),
            );
          },
        ),
      ),
    );
  }

}