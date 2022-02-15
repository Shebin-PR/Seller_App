import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salt_n_pepper_seller/Controller/api_services.dart';
import 'package:salt_n_pepper_seller/Model/global.dart';
import 'package:salt_n_pepper_seller/Model/menu_model.dart';
import 'package:salt_n_pepper_seller/View/Widgets/addmenuscreen.dart';
import 'package:salt_n_pepper_seller/View/Widgets/drawer.dart';
import 'package:salt_n_pepper_seller/View/itemscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _api = ApiServices();
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
        body: ListView(
          children: [
            const Center(
              child: Text(
                "My Menuss",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder(
              stream: _api.getMenus(sharedPreferences!.getString("uid")!),
              builder: (context, snapshot) {
                List<Menus> data = [];
                if (snapshot.hasData) {
                  // ignore: cast_nullable_to_non_nullable
                  data = snapshot.data as List<Menus>;
                  // print(data.first.menuTitle);
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ItemScreen(
                              data: data[index],
                            ),
                          );
                        },
                        child: Card(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Image.network(
                                data[index].thumbnail!,
                                fit: BoxFit.fill,
                                frameBuilder: (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) =>
                                    child,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              Container(
                                height: maxHeight * 0.15,
                                width: maxWidth,
                                color: Colors.black.withOpacity(0.6),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        data[index].menuTitle!,
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data[index].aboutMenu!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
