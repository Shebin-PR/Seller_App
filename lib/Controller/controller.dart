import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  bool? userIsAlreadyLogin;
  String verificationId = "";
  @override
  void onInit() {
    checkLoginOrNot();
    super.onInit();
  }

  checkLoginOrNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userIsAlreadyLogin = prefs.getBool("login");
    update();
  }
}
