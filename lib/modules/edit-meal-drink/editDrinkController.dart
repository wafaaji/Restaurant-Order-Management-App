import 'package:employee/model/categoryModel.dart';
import 'package:employee/model/editMainMealsModel.dart';
import 'package:employee/model/mealsDrinksModel.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/modules/edit-meal-drink/editMealDrinkService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditDrinkController extends GetxController {

  RxString imagePath = ''.obs;

  final editDrinksFormKey = GlobalKey<FormState>();
  late TextEditingController nameController , priceController , detailsController;
  var name;
  var price;
  var details;


  var message;
  late EditMainMealService service;
  var editMainMealStatus;

  //
  List<Category> drinkCategories = [];
  SecureStorage storage = SecureStorage();
  Rx<Category> selectedCategory = Rx(Category(
    id: -1,
    name: "Default Category",
    type: "",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ));
  //

  @override
  void onInit(){
    nameController = TextEditingController();
    priceController = TextEditingController();
    detailsController = TextEditingController();

    name = '';
    price = '';
    details = '';

    message = '';
    service = EditMainMealService();
    editMainMealStatus = false;

    //
    fetchMealCategories();
    //

    super.onInit() ;
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();

    nameController.dispose();
    priceController.dispose();
    detailsController.dispose();
  }

  void fetchMealCategories() async {
    var token = await storage.read("token"); // Replace with actual token
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      // Filter the list to include only meal categories
      drinkCategories = categoryList.where((category) => category.type == "drink").toList();

      if (drinkCategories.isNotEmpty) {
        setSelectedCategory(drinkCategories[0].name);
      }
    } catch (e) {
      print("Error fetching meal categories: $e");
    }
  }

  void setSelectedCategory(String value) {
    selectedCategory.value = drinkCategories.firstWhere(
          (category) => category.name == value,
      orElse: () => Category(
        id: -1,
        name: "Default Category",
        type: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }


  Future<void> pickImageGallery() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path; // Update imagePath
    }
  }

  Future<void> pickImageCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path; // Update imagePath
    }
  }


  Future<void> editCategoryOnClick(MealsDrinks mealsDrinks) async{
    EasyLoading.show(status: "loading...");


    //var imageFile; // Initialize with null

    // if (imageFile.value != mealsDrinks.image) {
    //   // User has selected a new image, so create a MultipartFile
    //   var newImageFile = File(imageFile.value);
    //   imageFile = await http.MultipartFile.fromPath('image', newImageFile.path);
    // }

    EditMainMeal editCategory = EditMainMeal(
      meal_id: mealsDrinks.id,
      name: nameController.text,
      description :  detailsController.text,
      price : priceController.text,
      image : imagePath.value,
      //
      categoryId: selectedCategory.value.id,
      //
    );
    editMainMealStatus = await service.editMainMeal(editCategory);
    message = service.message;

    if (message is List) {
      String temp = '';
      for (String s in message) temp += s + "\n";
      message = temp;
    }
  }

  void updateFormValues(MealsDrinks mealsDrinks) {
    name = mealsDrinks.name;
    price = mealsDrinks.price.toString();
    details = mealsDrinks.description;

    // Update the text editing controllers
    nameController.text = name;
    priceController.text = price;
    detailsController.text = details;

    // ... Other potential updates ...
  }

}

