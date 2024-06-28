import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/modules/all-offers/allOffersController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class allOffersScreen extends GetView<AllOffersController> {

  @override
  Widget build(BuildContext context) {

    print(controller.allOffers);

    final deviceWidth = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
        }
        return RefreshIndicator(
          onRefresh: controller.fetchData,
          color: Color(0xFFBE0B0B),
          child: Padding(
            padding: EdgeInsets.only(top: 10.0,),
            child: Column(
              children: [
                Flexible(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
                    ),
                    child: ListView.builder(
                        itemCount: controller.allOffers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i){
                          final offer = controller.allOffers[i];
                          return Container(
                            color: Color(0xFFD9D9D9),
                            width: deviceWidth,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(top: 10.0, left: 25.0, bottom: 10.0, right: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                text: "${offer.newPrice.toString()} SP",
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "${offer.oldPrice.toString()} SP",
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: 15,
                                                  color: Colors.black.withOpacity(0.25),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          CustomText(
                                            text: "${offer.expirateDate.year.toString()} / ${offer.expirateDate.month.toString()} / ${offer.expirateDate.day.toString()}",
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          CustomText(
                                            text: offer.state == 1 ? "Active" : "UnActive",
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      CustomElevatedButton(
                                        onPressed: (){
                                          Get.toNamed("/offerOrderDetails", arguments: offer);
                                        },
                                        buttonText: "Show \nDetails",
                                        height: 40.0,
                                        buttonColor: Color(0xFFBE0B0B),
                                        borderRadius: BorderRadius.circular(20),
                                        textColor: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CustomElevatedButton(
                  onPressed: (){
                    Get.toNamed("/addOfferOrder");
                  },
                  buttonText: "Add Offer",
                  height: 40.0,
                  buttonColor: Color(0xFFBE0B0B),
                  borderRadius: BorderRadius.circular(20),
                  textColor: Colors.white,
                  fontSize: 20.0,
                ),
              ],
            ),
          ),
        );
      },),
    );
  }
}
