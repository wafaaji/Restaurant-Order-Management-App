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

class AddMealController extends GetxController {

  RxString imagePath = ''.obs;

  final addMealFormKey = GlobalKey<FormState>();
  late TextEditingController nameController , priceController , detailsController;
  var name;
  var price;
  var details;


  //update
  List<Category> mealCategories = [];
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
  var addMealStatus;
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
    addMealStatus = false;
    message = '';
    //
    selectCategory.value = mealCategories.isNotEmpty ? mealCategories[0].name : '';
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

  //
  void fetchMealCategories() async {
    var token = await storage.read("token"); // Replace with actual token
    try {
      var categoryList = await DisplayCategoryService().displayCategory(token);

      // Filter the list to include only meal categories
      mealCategories = categoryList.where((category) => category.type == "meal").toList();

      if (mealCategories.isNotEmpty) {
        setSelectedCategory(mealCategories[0].name);
      }
    } catch (e) {
      print("Error fetching meal categories: $e");
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
  //

  // Future<void> addMealsDrinksOnClick() async{
  //
  //   //
  //   // var selectedCategory = mealCategories.firstWhere(
  //   //       (category) => category['name'] == selectCategory.value,
  //   //   orElse: () => {'id': ''}, // Use a default value if not found
  //   // );
  //   //
  //
  //   //
  //   Category selectedCategory = mealCategories.firstWhere(
  //         (category) => category.name == selectCategory.value,
  //     orElse: () => Category(id: -1 , name: '', // Provide default values for all required properties
  //       type: '',
  //       createdAt: DateTime.now(),
  //       updatedAt: DateTime.now(),
  //     ), // Use a default value if category is not found
  //   );
  //   //
  //
  //   //
  //   // Create a http.MultipartFile from the image path
  //   var imageFile = File(imagePath.value);
  //   var imageMultipartFile = await http.MultipartFile.fromPath('image', imageFile.path);
  //   //
  //
  //   AddMealsDrinks addMealsDrinks = AddMealsDrinks(
  //     name: nameController.text,
  //     description :  detailsController.text,
  //     price : priceController.text,
  //     image : '',
  //     //
  //     categoryId: selectedCategory.id,
  //     //
  //     // categoryId: selectCategory.toString(),
  //   );
  //   addMealsDrinksStatus = await service.serviceAddMealsDrinks(addMealsDrinks , imageMultipartFile);
  //   message = service.message;
  //
  //   if (message is List) {
  //     String temp = '';
  //     for (String s in message) temp += s + "\n";
  //     message = temp;
  //   }
  // }

//
  Future<void> addMealOnClick() async {
    if (imagePath.isNotEmpty) {
      Category selectedCategory = mealCategories.firstWhere(
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

      addMealStatus = await service.serviceAddMealDrink(addMealsDrinks, imageMultipartFile);
      message = service.message;

      if (message is List) {
        String temp = '';
        for (String s in message) temp += s + "\n";
        message = temp;
      }
    } else {
      message = "Please pick an image before adding.";
    }
  }

//

  String? validateEmptyName (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add name to the meal';
    }
    return null;
  }

  String? validateEmptyPrice (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add price to the meal';
    }
    return null;
  }

  String? validateEmptyDescription (String value) {
    if (!GetUtils.isNull(value))
    {
      return 'Please add description to the meal';
    }
    return null;
  }



}
