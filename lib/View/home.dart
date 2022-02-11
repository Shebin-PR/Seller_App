import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:salt_n_pepper_seller/Controller/api_services.dart';
import 'package:salt_n_pepper_seller/Model/Authentication/addmenuscreen.dart';
import 'package:salt_n_pepper_seller/Model/global.dart';
import 'package:salt_n_pepper_seller/Model/menu_model.dart';
import 'package:salt_n_pepper_seller/View/Widgets/display_menus_in_home.dart';
import 'package:salt_n_pepper_seller/View/Widgets/drawer.dart';
import 'package:salt_n_pepper_seller/View/Widgets/progressbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices _api = ApiServices();
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.width;
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
        body: StreamBuilder(
          stream: _api.getMenus(sharedPreferences!.getString("uid")!),
          builder: (context, snapshot) {
            List<Menus> data = [];
            if (snapshot.hasData) {
              data = snapshot.data as List<Menus>;
              print(data.first.menuTitle);
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // controller.popularImages.add(data[index].thumbnail);
                  return Card(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        // FadeInImage.assetNetwork(
                        //     placeholder: "assets/slider/23.jpg",
                        //     image: data[index].thumbnail!),
                        Image.network(
                          data[index].thumbnail!,
                        ),
                        Container(
                          height: maxHeight * 0.1,
                          width: maxWidth,
                          color: Colors.black.withOpacity(0.6),
                          child: Center(
                            child: Text(
                              data[index].menuTitle!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
