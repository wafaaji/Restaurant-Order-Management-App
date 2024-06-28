import 'package:employee/components/customText.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/meals-drinks-details/mealDetailsController.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mealDetailsScreen extends GetView<MealDetailsController> {


  @override
  Widget build(BuildContext context) {

    var selectedMeal = Get.arguments as MealsDrinks;

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: Stack(
          children: [
            Container(
                height: height * 0.40,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(selectedMeal.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Positioned(
              top: 20.0,
              left: 15.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.2,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white.withOpacity(0.75),
                  ),
                  onPressed: () {
                    Get.toNamed("/mealsDrinks");
                    print("xxxxxxxxxxxxxx");
                  },
                ),
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
              ),
              child: Container(
                margin: EdgeInsets.only(top: height * 0.35),
                height: height * 0.70,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top:15.0, left: 15.0, right: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  CustomText(
                                    text: selectedMeal.name,
                                    fontSize: 25.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  // CustomText(
                                  //   text: selectedMeal.categoryId,
                                  //   fontSize: 20.0,
                                  //   color: Colors.black.withOpacity(0.25),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RatingBar.builder(
                                initialRating: selectedMeal.rate!.toDouble(),
                                //minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 24.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // Handle rating update
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          text: "${selectedMeal.price}",
                          fontSize: 25.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      CustomText(
                        text: "Details",
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CustomText(
                        text:  selectedMeal.description,
                        fontSize: 15.0,
                        color: Colors.black.withOpacity(0.50),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
