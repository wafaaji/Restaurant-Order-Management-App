import 'package:employee/components/customAppBar.dart';
import 'package:employee/components/customDialog.dart';
import 'package:employee/components/customElevatedButton.dart';
import 'package:employee/components/customGridCategory.dart';
import 'package:employee/components/customSubCategory.dart';
import 'package:employee/model/categoryModel.dart';
import 'package:employee/modules/category/categoryController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class categoryScreen extends GetView<CategoryController>  {

  void onTabSelected(String tab) {
    controller.updateCategoryListByTab(tab);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Category',
        onPressed: () {
          Get.toNamed("/home");
        },),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 60.0,
                width: double.infinity,
                child: CustomSubCategory(
                  items: controller.type,
                  current: controller.current,
                  onTap: (index) {
                    controller.current.value = index;
                    controller.categoryController.animateTo(index);
                    onTabSelected(controller.type[index]);
                  },
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.categoryController,
                children: List<Widget>.generate(
                           3,
                          (index) => Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                            child: RefreshIndicator(
                              onRefresh: controller.fetchData,
                              color: Color(0xFFBE0B0B),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFBE0B0B),)
                                ),
                                child: Obx(() => controller.isLoading.value == true?
                                Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFBE0B0B),
                                  ),
                                ):
                                GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.categoryList.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 1.3,
                                      mainAxisExtent: 120,
                                    ),
                                    itemBuilder: (context, i){
                                      final category = controller.categoryList[i];
                                      return CustomGridCategory(
                                          title: category.name,
                                          subTitle: category.type,
                                          editOnPressed: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                controller.editNameController.text = category.name;
                                                controller.setSelectedTypeDropDown(category.type);
                                                return Obx(() {
                                                  return CustomDialog(
                                                    title: 'Edit Category',
                                                    controller: controller.editNameController,
                                                    buttonLabel: 'Edit',
                                                    onPressed: () {
                                                      onClickEditCategory(category);
                                                    },
                                                    keyboardType: TextInputType.name,
                                                    textInputAction: TextInputAction.next,
                                                    onSaved: (value) {
                                                      controller.editName = value!;
                                                    },
                                                    defaultText: category.name,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    hint: 'Type',
                                                    onChanged: (newValue) {
                                                      controller.setSelectedTypeDropDown(newValue as String);
                                                    },
                                                    value: controller.selectTypeDropDown.value,
                                                    items: controller.typeDropDown.map((item) => item as String).toList(),
                                                  );
                                                }
                                                );
                                              },
                                            );
                                          },
                                          deleteOnPressed: () {
                                            onClickDeleteCategory(category);
                                          }
                                      );
                                    }
                                ),
                                ),
                              ),
                            ),
                          ),
                  ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: CustomElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Obx(() => CustomDialog(
                        title: 'Add Category',
                        controller: controller.nameController,
                        buttonLabel: 'Add',
                        onPressed: () {
                          onClickAddCategory();
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          controller.name = value!;
                        },
                        validator: (value){
                          return controller.validateEmptyName(value!);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                        ),
                        hint: 'Select Type',
                        onChanged: (newValue) {
                          controller.setSelectedTypeDropDown(newValue!);
                        },
                        value: controller.selectTypeDropDown.value,
                        items: controller.typeDropDown.map((item) => item as String).toList(),
                      ),);
                    },
                  );
                },
                buttonText: "Add Category",
                height: 40.0,
                buttonColor: Color(0xFFBE0B0B),
                borderRadius: BorderRadius.circular(20),
                fontSize: 20.0,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickAddCategory() async{
    EasyLoading.show(status: "loading...");

    await controller.addCategoryOnClick();

    if(controller.addCategoryStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );

      Get.toNamed("/category");
      await controller.updateCategoryList();
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

  void onClickEditCategory(Category category) async{
    EasyLoading.show(status: "loading...");

    await controller.editCategoryOnClick(category);

    if(controller.editCategoryStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/category");
      await controller.updateCategoryList();
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

  void onClickDeleteCategory(Category category) async{
    EasyLoading.show(status: "loading...");

    await controller.deleteCategoryOnClick(category);

    if(controller.deleteCategoryStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: Duration(seconds: 2),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.toNamed("/category");
      await controller.updateCategoryList();
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
