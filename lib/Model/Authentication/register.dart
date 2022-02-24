import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:salt_n_pepper_seller/View/HomeScreen/home.dart';
import 'package:salt_n_pepper_seller/View/Widgets/error_dialog.dart';
import 'package:salt_n_pepper_seller/View/Widgets/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  User? user;
  RegisterScreen({Key? key, this.user}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController sellerNamecontroller = TextEditingController();
  TextEditingController shopNamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  Position? position;

  List<Placemark>? placemarks;

  String completeAddress = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Register your shop",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 18, left: 18, right: 18),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: sellerNamecontroller,
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person_outline_outlined,
                                  color: Colors.blue,
                                ),
                                label: const Text(
                                  "Seller name",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 18, left: 18, right: 18),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: shopNamecontroller,
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.fastfood_outlined,
                                  color: Colors.blue,
                                ),
                                label: const Text(
                                  "Shop name",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 18, left: 18, right: 18),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: phonecontroller,
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone_outlined,
                                  color: Colors.blue,
                                ),
                                label: const Text(
                                  "Contact Number",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 18,
                          left: 18,
                          right: 18,
                          bottom: 18,
                        ),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: locationcontroller,
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.my_location,
                                  color: Colors.blue,
                                ),
                                label: const Text(
                                  "Cafe/Restaurant Address",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 50,
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 330,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          getCurrentLocation();
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        label: const Text(
                          "Get my current location",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 330,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.black,),
                        onPressed: () {
                          setState(() {
                            formValidator();
                          });
                        },
                        icon: const Icon(
                          Icons.folder_shared_rounded,
                          color: Colors.red,
                        ),
                        label: const Text(
                          "Register",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark pMark = placemarks![0];

    completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    locationcontroller.text = completeAddress;
  }

  formValidator() {
    if (shopNamecontroller.text.isNotEmpty &&
        sellerNamecontroller.text.isNotEmpty &&
        phonecontroller.text.isNotEmpty &&
        locationcontroller.text.isNotEmpty) {
      saveDataToFirestore(widget.user!);
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return const ErrorDialogWidget(
            message: "All fields are required . !",
          );
        },
      );
    }
  }

  saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerName": sellerNamecontroller.text.trim(),
      "shopName": shopNamecontroller.text.trim(),
      "phone": phonecontroller.text.trim(),
      "address": completeAddress,
      "status": "approved",
      "earnings": 0.0,
      "lat": position!.latitude,
      "lng": position!.longitude
    });
    showDialog(
      context: context,
      builder: (ctx) {
        return const LoadingDialogWidget(
          message: "Registering Account ",
        );
      },
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", currentUser.uid);
    prefs.setString("shopName", shopNamecontroller.text);
    Timer(const Duration(seconds: 3), goToHomeScreen);
  }

  goToHomeScreen() {
    Get.offAll(() => const HomeScreen());
  }
}
