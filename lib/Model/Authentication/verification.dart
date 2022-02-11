import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'package:salt_n_pepper_seller/Controller/controller.dart';
import 'package:salt_n_pepper_seller/Model/Authentication/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Verification extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Verification({
    Key? key,
  }) : super(key: key);
  // ignore: avoid_void_async
  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: controller.verificationId,
        smsCode: pinEditingController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user!;

      print("Successfully signed in UID: ${user.uid}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("login", true);

      Get.offAll(
        () => RegisterScreen(
          user: user,
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Invalid OTP",
        "PLEASE ENTER VALID OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
      // print(
      //   "Failed to sign in: " + e.toString(),
      // );
    }
  }

  TextEditingController pinEditingController = TextEditingController();
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(Controller());

    final oriantion = MediaQuery.of(context).orientation;
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: oriantion == Orientation.portrait || maxWidth <= 640
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      imgpart(context, maxHeight),
                      fieldpath(context, maxWidth),
                    ],
                  ),
                ),
              )
            : landscapeMode(context, maxHeight, maxWidth),
      ),
    );
  }

  Row landscapeMode(BuildContext context, double maxHeight, double maxWidth) {
    return Row(
      children: [
        imgpart(context, maxHeight * 1.2),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(
                  "Enter 6 digits verification code",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(
              width: maxWidth / 1.5,
              height: maxHeight / 4,
              child: PinInputTextField(
                controller: pinEditingController,
                decoration: BoxLooseDecoration(
                  strokeColorBuilder: PinListenColorBuilder(
                    Colors.grey[300]!,
                    Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: maxWidth / 2,
                child: ElevatedButton(
                  onPressed: () {
                    pinEditingController.text.length != 6
                        ? Get.snackbar(
                            "Invalid",
                            "Please Enter Valid Otp",
                            snackPosition: SnackPosition.BOTTOM,
                          )
                        : signInWithPhoneNumber();
                  },
                  child: const Text("Verify"),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Resend Otp"),
              ),
            )
          ],
        )
      ],
    );
  }

  Column fieldpath(BuildContext context, double maxWidth) {
    return Column(
      children: [
        Text(
          "Enter 6 digits verification code",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: PinInputTextField(
            controller: pinEditingController,
            decoration: BoxLooseDecoration(
              strokeColorBuilder: PinListenColorBuilder(
                Colors.grey[300]!,
                Colors.black,
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: maxWidth / 1.4,
            child: ElevatedButton(
              onPressed: () {
                if (pinEditingController.text.length != 6) {
                  Get.snackbar("Invalid", "Please Enter Valid Otp");
                }
                signInWithPhoneNumber();
              },
              child: const Text("Verify"),
            ),
          ),
        ),
        // Center(
        //   child: TextButton(onPressed: () {}, child: const Text("Resend Otp")),
        // )
      ],
    );
  }

  Column imgpart(BuildContext context, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify Mobile\nNumber",
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: size / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Image.asset(
                "assets/images/Enter OTP-bro.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
