import 'package:get/get.dart';
import 'package:salt_n_pepper_seller/Model/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<Menus> menuItems(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Menus(
        aboutMenu: (e.data() as dynamic)["aboutMenu"].toString(),
        menuID: (e.data() as dynamic)["menuID"].toString(),
        publishedDate: (e.data() as dynamic)["publishedDate"].toString(),
        sellerUID: (e.data() as dynamic)["sellerUID"].toString(),
        thumbnail: (e.data() as dynamic)["thumbnail"].toString(),
        status: (e.data() as dynamic)["status"].toString(),
        menuTitle: (e.data() as dynamic)["title"].toString(),
      );
    },).toList();
  }

  Stream getMenus(String uid) {
    return firebaseFirestore
        .collection("sellers")
        .doc(uid)
        .collection("menus")
        .snapshots()
        .map(menuItems);
  }
}
