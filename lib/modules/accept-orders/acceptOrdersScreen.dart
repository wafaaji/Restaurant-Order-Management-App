import 'package:employee/components/customCircleAvatar.dart';
import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/model/ordersModel.dart';
import 'package:employee/modules/accept-orders/acceptOrdersController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class acceptOrdersScreen extends GetView<AcceptOrderController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
          }
          return RefreshIndicator(
            onRefresh: controller.fetchData,
            color: Color(0xFFBE0B0B),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
                        ),
                        child: ListView.builder(
                            itemCount: controller.allOrders.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i){
                              final order = controller.allOrders[i];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed("/orderDetails", arguments: order);
                                },
                                child: Card(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    //height: 10.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    padding: EdgeInsets.only(top: 5.0, left: 10.0, bottom: 5.0, right: 20.0),
                                    child: Row(
                                      children: [
                                        CustomCircleAvatar(
                                          imagePath: "assets/order.jpg",
                                          radius: 40,
                                        ),
                                        SizedBox(
                                          width: 30.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: "Order ${order.id.toString()}",
                                              fontSize: 25.0,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 45.0,
                                          alignment: Alignment.topRight,
                                          child: CustomText(
                                            text: order.totalPrice.toString(),
                                            fontSize: 15.0,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          );
        })
    );
  }

}
