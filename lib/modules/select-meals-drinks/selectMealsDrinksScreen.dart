import 'package:employee/components/customCircleAvatar.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/select-meals-drinks/selectMealsDrinksController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class selectMealsDrinksScreen extends GetView<SelectMealsDrinksController> {


  @override
  Widget build(BuildContext context) {

    controller.onInit();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBE0B0B),
        title: CustomText(
          text: 'Meals/Drinks',
          fontSize: 25.0,
          color: Colors.white,
        ),
        bottom: TabBar(
          isScrollable: false,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          labelStyle: GoogleFonts.lato(
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
          controller: controller.tabController,
          tabs: [
            Tab(text: 'Meals'),
            Tab(text: 'Drinks'),
          ],
        ),
      ),
      body: TabBarView(
          controller: controller.tabController,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
              }
              return ListView.builder(
                itemCount: controller.mealList.length,
                itemBuilder: (context, index) {
                  final meal = controller.mealList[index];
                  return GestureDetector(
                    key: ValueKey(index),
                    onTap: () {
                      controller.toggleMealSelection(meal);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color:  Color(0xFFD9D9D9),
                      ),
                      child: Row(
                        children: [
                          CustomCircleAvatar(
                            imagePath: meal.image,
                            radius: 35.0,
                          ),
                          SizedBox(width: 20.0),
                          CustomText(
                            text: meal.name,
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
              }
              return ListView.builder(
                itemCount: controller.drinkList.length,
                itemBuilder: (context, index) {
                  final drink = controller.drinkList[index];
                  return GestureDetector(
                    key: ValueKey(index),
                    onTap: () {
                      controller.toggleDrinkSelection(drink);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFD9D9D9),
                      ),
                      child: Row(
                        children: [
                          CustomCircleAvatar(
                            imagePath: drink.image,
                            radius: 35.0,
                          ),
                          SizedBox(width: 30.0),
                          CustomText(
                            text: drink.name,
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> selectedMeals = controller.getSelectedMealIds();
          List<String> selectedDrinks = controller.getSelectedDrinkIds();
          //Get.to(addOfferOrderScreen(selectedMeals: selectedMeals,selectedDrinks: selectedDrinks));
          Get.toNamed("/addOfferOrder", arguments: {
            "selectedMeals": selectedMeals,
            "selectedDrinks": selectedDrinks,
          });
          print('Selected Meals: $selectedMeals');
          print('Selected Drinks: $selectedDrinks');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check),
            SizedBox(height: 4.0),
            Obx(() => Text('${controller.selectedItemCount}')),
          ],
        ),
        backgroundColor: Color(0xFFBE0B0B),
      ),
    );
  }

}

