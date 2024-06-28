import 'package:employee/components/customCircleAvatar.dart';
import 'package:employee/components/customContainer.dart';
import 'package:employee/components/customIconButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class orderDetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var selectedOrder = Get.arguments as Orders;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 8.0,left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconButton(
              icon: Icons.arrow_back_outlined,
              color: Color(0xFFBE0B0B),
              size: 25.0,
              onPressed: () {
                Get.toNamed("/orders");
              },
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Components of Order",
                    fontSize: 20.0,
                    color: Color(0xFFBE0B0B),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    height: 135.0,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch().copyWith(
                          secondary: Color(0xFFBE0B0B),
                        ),
                      ),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedOrder.orderItem.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 120,
                        ),
                        itemBuilder: (context, i) {
                          var mealItem = selectedOrder.orderItem[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 2.0,
                                ),
                                CircleAvatar(
                                    backgroundColor: Color(0xFFBE0B0B),
                                    radius: 40.0,
                                    backgroundImage:NetworkImage(mealItem.meal.image),
                                ),
                                CustomText(
                                  text: mealItem.meal.name,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                CustomText(
                                  text: mealItem.meal.price.toString(),
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Details of Order",
                    fontSize: 20.0,
                    color: Color(0xFFBE0B0B),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch().copyWith(
                          secondary: Color(0xFFBE0B0B),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomContainer(
                              iconData: Icons.shopping_basket_outlined,
                              text: "Orders ${selectedOrder.id}",
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomContainer(
                              iconData: Icons.attach_money_outlined,
                              text: selectedOrder.totalPrice.toString(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomContainer(
                              height: 200.0,
                              iconData: Icons.info_outline,
                              text: selectedOrder.additionalDetails,
                              maxLines: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
