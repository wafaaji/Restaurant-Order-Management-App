import 'package:employee/native-services/secureStorage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  late SecureStorage storage;

  @override
  void onInit() async{
    print("aaa");
    await Future.delayed(Duration(seconds: 8));
    storage = SecureStorage();
    await checkToken();
    super.onInit();
  }

  @override
  void onReady(){
    print("bbb");
    super.onReady();
  }

  Future<void> checkToken() async {
    String? token = await storage.read("token");
    print("token: ${token}");

    if(token != null){
      Get.offNamed('/home');
    }else{
      Get.offNamed('/login');
    }
  }

}