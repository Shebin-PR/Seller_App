import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _auth = FirebaseAuth.instance;

  TextEditingController shopOwnerNamecontroller = TextEditingController();
  TextEditingController shopNamecontroller = TextEditingController();
  TextEditingController contactNumbercontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  Position? position;

  List<Placemark>? placemarks;

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

    String completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    locationcontroller.text = completeAddress;
  }

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
                              controller: shopOwnerNamecontroller,
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
                                  "Shop Owner name",
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
                              controller: contactNumbercontroller,
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
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {},
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
}















/////////////////// logout ////////////////////
//                  ElevatedButton(
//                 onPressed: () async {
//                   await _auth.signOut();
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Logout"),
//               )
