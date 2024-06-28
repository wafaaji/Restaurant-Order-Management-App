import 'dart:io';
import 'package:employee/model/addMainMealDrinkModel.dart';
import 'package:employee/modules/add-meal-drinks/addMealDrinkService.dart';
import 'package:employee/modules/category/displayCategoryService.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:employee/model/categoryModel.dart';
import 'package:http/http.dart' as http;

class AddDrinkController extends GetxController {

  RxString imagePath = ''.obs;

  final addDrinkFormKey = GlobalKey<FormState>();
  late TextEditingController nameController , priceController , detailsController;
  var name;
  var price;
  var details;


  //update
  List<Category> drinkCategories = [];
  SecureStorage storage = SecureStorage();
  //

  List items= [
    "Fast Food",
    "Appetizers",
    "Salads",
    "Soups",
    "Main Courses",
    "Pizza",
    "Sides Dishes",
    "Desserts",
    "Non-Alcoholic Beverages",
  ];

  RxString selectCategory = RxString('');

  // late AddMealsDrinksService service;
  late AddMealDrinkService service;
  var addDrinkStatus;
  var message;

  @override
  void onInit(){
    nameController = TextEditingController();
    priceController = TextEditingController();
    detailsController = TextEditingController();

    name = '';
    price = '';
    details = '';


    selectCategory.value = items[0];

    service = AddMealDrinkService();
    addDrinkStatus = false;
    message = '';
    //
    selectCategory.value = drinkCategories.isNotEmpty ? drinkCategories[0].name : '';
    fetchDrinkCategories();
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

  //
  void fetchDrinkCategories() async {
    var token = await storage.read("token"); // Replace with actual token
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      // Filter the list to include only drink categories
      drinkCategories = categoryList.where((category) => category.type == "drink").toList();

      if (drinkCategories.isNotEmpty) {
        setSelectedCategory(drinkCategories[0].name);
      }
    } catch (e) {
      print("Error fetching drink categories: $e");
    }
  }
  //

  void setSelectedCategory(String value){
    selectCategory.value = value;
  }

  // Future<void> pickImageGallery() async {
  //   final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imagePath.value = pickedFile.path;
  //   }
  // }
  //
  // Future<void> pickImageCamera() async {
  //   final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     imagePath.value = pickedFile.path;
  //   }
  // }

  //
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

  Future<void> addDrinkOnClick() async {
    if (imagePath.isNotEmpty) {
      Category selectedCategory = drinkCategories.firstWhere(
            (category) => category.name == selectCategory.value,
        orElse: () => Category(
          id: -1,
          name: '',
          type: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      var imageFile = File(imagePath.value);
      var imageMultipartFile = await http.MultipartFile.fromPath('image', imageFile.path);

      AddMainMealDrink addMealsDrinks = AddMainMealDrink(
        name: nameController.text,
        description: detailsController.text,
        price: priceController.text,
        image: '',
        categoryId: selectedCategory.id,
      );

      addDrinkStatus = await service.serviceAddMealDrink(addMealsDrinks, imageMultipartFile);
      message = service.message;

      if (message is List) {
        String temp = '';
        for (String s in message) temp += s + "\n";
        message = temp;
      }
    } else {
      message = "Please pick an image before adding.";
      // Handle the case where the image is not picked
    }
  }

//

  String? validateEmptyName (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add name to the drink';
    }
    return null;
  }

  String? validateEmptyPrice (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add price to the drink';
    }
    return null;
  }

  String? validateEmptyDescription (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add description to the drink';
    }
    return null;
  }


}
