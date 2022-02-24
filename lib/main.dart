import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_n_pepper_seller/Controller/controller.dart';
import 'package:salt_n_pepper_seller/Model/Authentication/loginpage.dart';
import 'package:salt_n_pepper_seller/Model/global.dart';
import 'package:salt_n_pepper_seller/View/HomeScreen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) {
        print(controller.userIsAlreadyLogin);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: controller.userIsAlreadyLogin == true
              ? const HomeScreen()
              : LoginPage(),
        );
      },
    );
  }
}
