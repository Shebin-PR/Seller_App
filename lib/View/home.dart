import 'package:flutter/material.dart';
import 'package:salt_n_pepper_seller/Model/Authentication/addmenuscreen.dart';
import 'package:salt_n_pepper_seller/Model/global.dart';
import 'package:salt_n_pepper_seller/View/Widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Text(sharedPreferences!.getString("shopName").toString()),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const AddMenuScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.food_bank_rounded,
                size: 30,
              ),
            )
          ],
        ),
        body: Center(
          child: Column(),
        ),
      ),
    );
  }
}
