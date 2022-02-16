import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salt_n_pepper_seller/Model/itemmodel.dart';
import 'package:salt_n_pepper_seller/Model/menu_model.dart';

class ApiServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<Menus> menuItems(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (e) {
        return Menus(
          // ignore: avoid_dynamic_calls
          aboutMenu: (e.data() as dynamic)["aboutMenu"].toString(),
          // ignore: avoid_dynamic_calls
          menuID: (e.data() as dynamic)["menuID"].toString(),
          // ignore: avoid_dynamic_calls
          publishedDate: (e.data() as dynamic)["publishedDate"].toString(),
          // ignore: avoid_dynamic_calls
          sellerUID: (e.data() as dynamic)["sellerUID"].toString(),
          // ignore: avoid_dynamic_calls
          thumbnail: (e.data() as dynamic)["thumbnail"].toString(),
          // ignore: avoid_dynamic_calls
          status: (e.data() as dynamic)["status"].toString(),
          // ignore: avoid_dynamic_calls
          menuTitle: (e.data() as dynamic)["title"].toString(),
        );
      },
    ).toList();
  }

  Stream getMenus(String uid) {
    return firebaseFirestore
        .collection("sellers")
        .doc(uid)
        .collection("menus")
        .snapshots()
        .map(menuItems);
  }

  List<ItemModel> items(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (e) {
        return ItemModel(
          discription: (e.data() as dynamic)["discription"].toString(),
          aboutItem: (e.data() as dynamic)["aboutItem"].toString(),
          itemId: (e.data() as dynamic)["itemID"].toString(),
          publishedDate: (e.data() as dynamic)["publishedDate"].toString(),
          sellerUID: (e.data() as dynamic)["sellerUID"].toString(),
          thumbnail: (e.data() as dynamic)["thumbnail"].toString(),
          status: (e.data() as dynamic)["status"].toString(),
          title: (e.data() as dynamic)["title"].toString(),
          size: (e.data() as dynamic)["size"] as Map,
        );
      },
    ).toList();
  }

  Stream getItems(String uid, String MenuId) {
    return firebaseFirestore
        .collection("sellers")
        .doc(uid)
        .collection("menus")
        .doc(MenuId)
        .collection("items")
        .snapshots()
        .map(items);
  }
}
