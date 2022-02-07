import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.8,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        label: const Text(
                          "Shop Owner name",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
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
                padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.8,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        label: const Text(
                          "Shop name",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
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
                padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.8,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        label: const Text(
                          "Contact Number",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
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
                padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.8,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        label: const Text(
                          "Cafe/Restaurant Address",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 250,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  label: const Text("Get my current location"),
                ),
              )
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
