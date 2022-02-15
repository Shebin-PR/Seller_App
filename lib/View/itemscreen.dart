import 'package:flutter/material.dart';
import 'package:salt_n_pepper_seller/Model/menu_model.dart';
import 'package:salt_n_pepper_seller/View/Widgets/addnewitem.dart';

class ItemScreen extends StatefulWidget {
  Menus data;
  ItemScreen({required this.data, Key? key}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data.menuTitle!),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) =>  AddNewItem(widget.data),
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
        body: const Center(),
      ),
    );
  }
}
