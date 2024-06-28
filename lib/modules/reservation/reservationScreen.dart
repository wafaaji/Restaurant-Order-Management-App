import 'package:employee/components/customAppBar.dart';
import 'package:employee/components/customContainer.dart';
import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/model/reservationModel.dart';
import 'package:employee/modules/reservation/reservationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class reservationScreen extends GetView<ReservationController> {

  @override
  Widget build(BuildContext context) {

    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: Obx(() {
      if (controller.isLoading.value) {
        return Center(
            child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
      }
        return Padding(
          padding: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
          child: RefreshIndicator(
            onRefresh: controller.fetchData,
            color: Color(0xFFBE0B0B),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Accept/Reject Reservation',
                  fontSize: 25,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: deviceHeight * 0.60,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                        secondary: Color(0xFFBE0B0B),
                      ),
                    ),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.allReservation.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 30,
                        mainAxisExtent: 220,
                      ),
                      itemBuilder: (context, i) {
                        final reservation = controller.allReservation[i];
                        return Container(
                          decoration: BoxDecoration(
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
                              Stack(
                                children: [
                                  Container(
                                    height: deviceHeight * 0.20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage("assets/Reserved.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: deviceHeight * 0.20),
                                    height: deviceHeight * 0.40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  CustomContainer(
                                    margin: EdgeInsets.only(top: 85.0),
                                    iconData: Icons.local_restaurant_outlined,
                                    text: "reservation ${reservation.id}",
                                  ),
                                  CustomContainer(
                                    margin: EdgeInsets.only(top: 130.0),
                                    iconData: Icons.date_range_outlined,
                                    text: "1/12/2022",
                                  ),
                                  CustomContainer(
                                    margin: EdgeInsets.only(top: 175.0),
                                    iconData: Icons.access_time,
                                    text: "18:00",
                                  ),
                                  CustomContainer(
                                    margin: EdgeInsets.only(top: 220.0),
                                    iconData: Icons.format_list_numbered,
                                    text: "Floor 1",
                                  ),
                                  CustomContainer(
                                    margin: EdgeInsets.only(top: 265.0),
                                    iconData: Icons.table_bar,
                                    text: "Table ${reservation.tabelId}",
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 315.0, left: 20.0, right: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomElevatedButton(
                                          onPressed: (){
                                            onClickAcceptReservation(reservation);
                                          },
                                          buttonText: "Accept",
                                          height: 30.0,
                                          buttonColor: Color(0xFFBE0B0B),
                                          borderRadius: BorderRadius.circular(20),
                                          fontSize: 15,
                                          textColor: Colors.white,
                                        ),
                                        CustomElevatedButton(
                                          onPressed: (){
                                            onClickRejectReservation(reservation);
                                          },
                                          buttonText: "Reject",
                                          height: 30.0,
                                          buttonColor: Color(0xFFD9D9D9),
                                          borderRadius: BorderRadius.circular(20),
                                          fontSize: 15,
                                          textColor: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
        );
      }),
    );
  }

  void onClickAcceptReservation(Reservation reservation) async{
    EasyLoading.show(status: "loading...");

    await controller.acceptRejectReservationOnClick(reservation, 2);

    if(controller.acceptRejectReservationStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/theReservation");
      await controller.updateAcceptRejectReservationList();
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

  void onClickRejectReservation(Reservation reservation) async{
    EasyLoading.show(status: "loading...");

    await controller.acceptRejectReservationOnClick(reservation, 1);

    if(controller.acceptRejectReservationStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/theReservation");
      await controller.updateAcceptRejectReservationList();
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
