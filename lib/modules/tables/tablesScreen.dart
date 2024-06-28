import 'package:employee/components/customAppBar.dart';
import 'package:employee/components/customRowButton.dart';
import 'package:employee/components/customRowIconText.dart';
import 'package:employee/components/customText.dart';
import 'package:employee/model/tablesModel.dart';
import 'package:employee/modules/tables/tablesController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';


class tablesScreen extends GetView<TablesController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tables',
        onPressed: () {Get.toNamed("/home");},
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(color: Color(0xFFBE0B0B),));
        }
        return ListView.builder(
          itemCount: controller.allTables.length,
          itemBuilder: (context, i) {
            final tables = controller.allTables[i];
            return RefreshIndicator(
              onRefresh: controller.fetchData,
              color: Color(0xFFBE0B0B),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 175.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD9D9D9),
                          ),
                          child: Center(
                            child: CustomText(
                              text: tables.tableNumber.toString(),
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRowIconText(
                                icon: Icons.chair_alt_outlined,
                                text: '${tables.chairsNumber.toString()}  Chairs',
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              CustomRowIconText(
                                icon: Icons.format_list_numbered,
                                text: '${tables.floorNumber.toString()}  Floor',
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              CustomRowIconText(
                                icon: Icons.lock_open,
                                text: tables.state == 1 ? "Open" : "Close",
                              ),
                              SizedBox(
                                  height: 10.0
                              ),
                              CustomRowButton(
                                onLeftPressed: () {
                                  onClickOpen(tables);
                                },
                                onRightPressed: () {
                                  onClickClose(tables);
                                },
                                buttonLeftText: "Open",
                                buttonRightText: 'Close',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }


  void onClickOpen(Tables tables) async{
    EasyLoading.show(status: "loading...");

    await controller.OpenCloseTableOnClick(tables, 1);

    if(controller.openCloseTableStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/tables");
      await controller.updateOpenCloseTableList();
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

  void onClickClose(Tables tables) async{
    EasyLoading.show(status: "loading...");

    await controller.OpenCloseTableOnClick(tables, 2);

    if(controller.openCloseTableStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/tables");
      await controller.updateOpenCloseTableList();
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
