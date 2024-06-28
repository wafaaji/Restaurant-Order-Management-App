import 'package:employee/components/customCircleAvatar.dart';
import 'package:employee/components/customContainer.dart';
import 'package:employee/components/customIconButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/model/offersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class offerOrderDetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var selectOffer = Get.arguments as Offers;

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
                  Get.toNamed("/offers");
                },
              ),
              Expanded(
                flex: 4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Components of Offers",
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
                                itemCount: selectOffer.offerItem.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 15,
                                  mainAxisExtent: 120,
                                ),
                                itemBuilder: (context, i) {
                                  var mealItem = selectOffer.offerItem[i];
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
                            text: "Details of Offers",
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
                                      iconData: Icons.attach_money_outlined,
                                      text: selectOffer.newPrice.toString(),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomContainer(
                                      iconData: Icons.attach_money_outlined,
                                      text: selectOffer.oldPrice.toString(),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomContainer(
                                      iconData: Icons.date_range_outlined,
                                      text: "${selectOffer.expirateDate.year} / ${selectOffer.expirateDate.month} / ${selectOffer.expirateDate.day}",
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomContainer(
                                      iconData: Icons.update_disabled,
                                      text: selectOffer.state == 1 ? "Active" : "UnActive",
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomContainer(
                                      height: 200.0,
                                      iconData: Icons.info_outline,
                                      text: selectOffer.description,
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
