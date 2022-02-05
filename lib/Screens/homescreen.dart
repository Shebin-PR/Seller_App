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
        body: Column(
          children: [
            Container(
              color: Colors.deepPurpleAccent,
              child: Text(
                "Hello World",
                style: TextStyle(fontSize: 30, color: Colors.black26),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
