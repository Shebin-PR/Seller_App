import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? aboutMenu;
  String? thumbnail;
  String? status;
  String? publishedDate;

  Menus({
    this.menuID,
    this.sellerUID,
    this.menuTitle,
    this.aboutMenu,
    this.thumbnail,
    this.status,
    this.publishedDate,
  });

  Menus.fromJson(Map<String, String> json) {
    menuID = json["menuID"];
    sellerUID = json["sellerUID"];
    menuTitle = json["menuTitle"];
    aboutMenu = json["aboutMenu"];
    thumbnail = json["thumbnail"];
    status = json["status"];
    publishedDate = json["publishedDate"];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = Map<String, String>();
    data["menuID"] = menuID!;
    data["sellerUID"] = sellerUID!;
    data["menuTitle"] = menuTitle!;
    data["aboutMenu"] = aboutMenu!;
    data["thumbnail"] = thumbnail!;
    data["status"] = status!;
    data["publishedDate"] = this.publishedDate!;

    return data;
  }
}
