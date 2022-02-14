import 'package:flutter/material.dart';
import 'package:salt_n_pepper_seller/Model/menu_model.dart';

// ignore: must_be_immutable
class DisplayMenuList extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  DisplayMenuList({this.model, this.context});

  @override
  _DisplayMenuListState createState() => _DisplayMenuListState();
}

class _DisplayMenuListState extends State<DisplayMenuList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image.network(widget.model!.thumbnail.toString()),
          const SizedBox(
            height: 30,
          ),
          Text(widget.model!.menuTitle.toString())
        ],
      ),
    );
  }
}
