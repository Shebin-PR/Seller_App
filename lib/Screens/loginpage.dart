import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salt_n_pepper_seller/Screens/homescreen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final mobileNoController = TextEditingController();
  final otpController = TextEditingController();
  final _formKey = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    // final oriantion = MediaQuery.of(context).orientation;
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: maxWidth,
            height: maxHeight,
            child: ListView(
              children: [
                showLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : currentState ==
                            MobileVerificationState.SHOW_MOBILE_FORM_STATE
                        // ? loginimg(maxHeight / 1.7)
                        ? TextFieldMethod(maxWidth, maxHeight / 1.7, context)
                        : CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column TextFieldMethod(
      double maxWidth, double maxHeight, BuildContext context) {
    return Column(
      children: [
        Container(
          height: maxHeight,
          child: Image.asset(
            "assets/images/Mobile login.gif",
          ),
        ),
        Container(
          height: maxWidth - 5,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "ENTER YOUR MOBILE NUMBER",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 20, right: 20, bottom: 8),
                child: Form(
                  key: _formKey,
                  child: Material(
                    elevation: 10.0,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      controller: mobileNoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Mobile Number";
                        } else if (value.length != 10) {
                          return "Enter Valid Mobile Number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: maxWidth / 1,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showLoading = true;
                    });
                    await _auth.verifyPhoneNumber(
                      phoneNumber: mobileNoController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        // signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text(verificationFailed.message.toString()),
                          ),
                        );
                      },
                      codeSent: (verificationId, ressendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState =
                              MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  },
                  child: const Text("Login With Otp"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  getOtpFormWidget() {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(hintText: "Enter otp"),
        ),
        SizedBox(
          height: 18,
        ),
        ElevatedButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otpController.text,
            );
            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("Verify"),
        ),
        Spacer(),
      ],
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      // TODO
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
      ;
    }
  }
}
