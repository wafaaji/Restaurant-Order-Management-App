import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customGridMainItem.dart';
import 'package:employee/components/customSubCategory.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/main-meals/mainMealsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class mainMealsScreen extends GetView<MainMealsController> {


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
                      controller.mainMealsController.animateTo(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.fetchData,
                  color: Color(0xFFBE0B0B),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.mainMealsController,
                    children: List<Widget>.generate(
                      controller.mealCategories.length + 1,
                          (index) {
                        if (index == 0) {
                          final allMainMealsList = controller.mainMealsList.toList();
                          return RefreshIndicator(
                            onRefresh: controller.fetchData,
                            color: Color(0xFFBE0B0B),
                           child: CustomTabContent(mealsList: allMainMealsList, onDeletePressed: onClickDeleteMainMeal),);
                        } else {
                          final category = controller.mealCategories[index - 1];
                          final mainMealsList = controller.mainMealsList
                              .where((meal) => meal.categoryId == category.id)
                              .toList();
                          return RefreshIndicator(
                            onRefresh: controller.fetchData,
                            color: Color(0xFFBE0B0B),
                            child: CustomTabContent(mealsList: mainMealsList, onDeletePressed: onClickDeleteMainMeal),);
                        }
                      },
                    ),
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
                    Get.toNamed("/addMeal");
                  },
                  buttonText: "Add Meal",
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
  void onClickDeleteMainMeal(MealsDrinks mealsDrinks) async{
    EasyLoading.show(status: "loading...");

    await controller.deleteMainMealOnClick(mealsDrinks);

    if(controller.deleteMainMealStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/mealsDrinks");
      await controller.updateMainMealList();
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
  final Function(MealsDrinks) onDeletePressed;

  CustomTabContent({required this.mealsList, required this.onDeletePressed});

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
            final mainMeals = mealsList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed("/mealDetails", arguments: mainMeals);
              },
              child: CustomGridMainItem(
                imagePath: mainMeals.image,
                text: mainMeals.name,
                editOnPressed: () {
                  Get.toNamed("/editMeal", arguments: mainMeals);
                },
                deleteOnPressed: () { onDeletePressed(mainMeals); },
              ),
            );
          },
        ),
      ),
    );
  }

}