import 'package:flutter/material.dart';
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
          title: const Text("HomePage"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(),
        ),
      ),
    );
  }
}
