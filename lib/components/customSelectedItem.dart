import 'package:flutter/material.dart';

class CustomSelectedItem extends StatelessWidget {
  final List<dynamic>? selectedMeals;
  final List<dynamic>? selectedDrinks;
  final Key? mealListKey;
  final Key? drinkListKey;

  CustomSelectedItem({
    this.selectedMeals,
    this.selectedDrinks,
    this.mealListKey,
    this.drinkListKey});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250.0,
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (selectedMeals != null && selectedMeals!.isNotEmpty)
                ListTile(
                  title: Text(
                    'Selected Meals',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFBE0B0B),
                    ),
                  ),
                ),
              if (selectedMeals != null && selectedMeals!.isNotEmpty)
                SizedBox(
                  height: 150.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    key: mealListKey,
                    itemCount: selectedMeals!.length,
                    itemBuilder: (context, index) {
                      final meal = selectedMeals![index];
                      return ListTile(
                        title: Text(
                          meal.name,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(meal.image),
                        ),
                      );
                    },
                  ),
                ),
              if (selectedDrinks != null && selectedDrinks!.isNotEmpty)
                ListTile(
                  title: Text(
                    'Selected Drinks',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFBE0B0B),
                    ),
                  ),
                ),
              if (selectedDrinks != null && selectedDrinks!.isNotEmpty)
                SizedBox(
                  height: 150.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    key: drinkListKey,
                    itemCount: selectedDrinks!.length,
                    itemBuilder: (context, index) {
                      final drink = selectedDrinks![index];
                      return ListTile(
                        title: Text(
                          drink.name,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(drink.image),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
