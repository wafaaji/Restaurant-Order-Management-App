import 'package:employee/model/addCategoryModel.dart';
import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/deleteCategory.dart';
import 'package:employee/model/editCategoryModel.dart';
import 'package:employee/modules/category/addCategoryService.dart';
import 'package:employee/modules/category/deleteCategoryService.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/category/editCategoryService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

  class CategoryController extends GetxController with SingleGetTickerProviderMixin {

    late TextEditingController nameController;
    late TextEditingController editNameController;

    var name;
    var editName;

    late TabController categoryController;

    //for tab
    final List<String> type = [
    "All",
    "Meals",
    "Drinks",
    ];
    late RxInt current;

    //for dropDown
    late List typeDropDown = [
      "meal",
      "drink",
    ];
    RxString selectTypeDropDown = RxString('');
    void setSelectedTypeDropDown(String value){
      selectTypeDropDown.value = value;
    }

    SecureStorage storage = SecureStorage();

    // for add category
    late AddCategoryService serviceAdd;
    var addCategoryStatus;
    var message;

    // for edit category
    late EditCategoryService serviceEdit;
    var editCategoryStatus;

    // for delete category
    late DeleteCategoryService serviceDelete;
    var deleteCategoryStatus;

    //for display category
    late DisplayCategoryService serviceDisplay;
    var categoryList = <Category>[].obs;
    late List<Category> allCategories = [];
    late List<Category> mealCategories = [];
    late List<Category> drinkCategories = [];
    var isLoading = true.obs;


    @override
    void onInit(){
      nameController = TextEditingController();
      editNameController = TextEditingController();
      name = '';
      editName = '';
      current = 0.obs;
      selectTypeDropDown.value = typeDropDown[0];
      serviceAdd = AddCategoryService();
      addCategoryStatus = false;
      message = '';
      serviceEdit = EditCategoryService();
      editCategoryStatus = false;
      serviceDelete = DeleteCategoryService();
      deleteCategoryStatus = false;
      serviceDisplay = DisplayCategoryService();

      super.onInit() ;

      categoryController = TabController(length: type.length, vsync: this);
    }

    @override
    void onReady() async{

      var token = await storage.read("token");
      allCategories = await serviceDisplay.displayCategory(token);
      mealCategories = allCategories.where((category) => category.type == "meal").toList();
      drinkCategories = allCategories.where((category) => category.type == "drink").toList();
      categoryList.value = allCategories;
      isLoading.value = false;

      super.onReady();
    }

    @override
    void onClose(){

      categoryController.dispose();

      super.onClose();

      nameController.dispose();
      editNameController.dispose();
    }

    Future<void> addCategoryOnClick() async{
      EasyLoading.show(status: "loading...");
      AddCategory addCategory = AddCategory(
        name: nameController.text,
        type: selectTypeDropDown.toString(),
      );
      addCategoryStatus = await serviceAdd.addCategory(addCategory);
      message = serviceAdd.message;

      if (message is List) {
        String temp = '';
        for (String s in message) temp += s + "\n";
        message = temp;
      }
    }

    void updateCategoryListByTab(String tab) {
      if (tab == "All") {
        categoryList.value = allCategories;
      } else if (tab == "Meals") {
        categoryList.value = mealCategories;
      } else if (tab == "Drinks") {
        categoryList.value = drinkCategories;
      }
    }

    Future<void> editCategoryOnClick(Category category) async{
      EasyLoading.show(status: "loading...");
        EditCategory editCategory = EditCategory(
          id: category.id,
          //name: editName.isNotEmpty ? editName.text : category.name,
          name : editNameController.text,
          type: selectTypeDropDown.toString(),
        );
        editCategoryStatus = await serviceEdit.editCategory(editCategory);
        message = serviceEdit.message;

      if (message is List) {
        String temp = '';
        for (String s in message) temp += s + "\n";
        message = temp;
      }
    }

    Future<void> deleteCategoryOnClick(Category category) async{
      DeleteCategory deleteCategory = DeleteCategory(
        id: category.id,
      );
      deleteCategoryStatus = await serviceDelete.deleteCategory(deleteCategory);
      message = serviceDelete.message;

      if (message is List) {
        String temp = '';
        for (String s in message) temp += s + "\n";
        message = temp;
      }
    }

    Future<void> updateCategoryList() async {
      isLoading.value = true;
      categoryList.clear();

      // Fetch the new list, populate it, and update isLoading
      var token = await storage.read("token");
      allCategories = await serviceDisplay.displayCategory(token);
      mealCategories = allCategories.where((category) => category.type == "meal").toList();
      drinkCategories = allCategories.where((category) => category.type == "drink").toList();
      categoryList.value = allCategories;
      isLoading.value = false;
    }

    Future<void> fetchData() async {
      isLoading.value = true;

      var token = await storage.read("token");
      allCategories = await serviceDisplay.displayCategory(token);
      mealCategories = allCategories.where((category) => category.type == "meal").toList();
      drinkCategories = allCategories.where((category) => category.type == "drink").toList();
      categoryList.value = allCategories;
      isLoading.value = false;

      await Future.delayed(Duration(seconds: 0)); // Simulate loading
      isLoading.value = false;
    }

    String? validateEmptyName (String value) {
      if (!GetUtils.isNull(value))
      {
        return 'Please add name to the category';
      }
      return null;
    }

  }