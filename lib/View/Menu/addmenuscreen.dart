import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salt_n_pepper_seller/View/Widgets/error_dialog.dart';
import 'package:salt_n_pepper_seller/View/Widgets/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({Key? key}) : super(key: key);

  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  XFile? imageXfile;
  final ImagePicker _picker = ImagePicker();
  String? userID;
  getid() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    userID = preferences.getString("uid");
  }

  TextEditingController aboutController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploadingMenu = false;

  @override
  void initState() {
    getid();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return imageXfile == null ? defaultScreen() : menuUploadScreen();
  }

  SafeArea defaultScreen() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[900],
          title: const Text("Add menu"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fastfood_rounded,
                size: 250,
                color: Colors.lightBlue[900],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  takeImage(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Add menu"),
              )
            ],
          ),
        ),
      ),
    );
  }

  takeImage(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Pic Image"),
          children: [
            SimpleDialogOption(
              child: const Text(
                "Camera",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                picImageWithCamera();
              },
            ),
            SimpleDialogOption(
              child: const Text(
                "Gallery",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                picImageWithGallery();
              },
            ),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  picImageWithCamera() async {
    Navigator.pop(context);
    imageXfile = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 250, maxWidth: 450);
    setState(() {
      imageXfile;
    });
  }

  picImageWithGallery() async {
    Navigator.pop(context);
    imageXfile = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 250, maxWidth: 450);
    setState(() {
      imageXfile;
    });
  }

  SafeArea menuUploadScreen() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[200],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              clearAllDetails();
              // Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          backgroundColor: Colors.lightBlue[900],
          title: const Text("Add menu"),
          centerTitle: true,
        ),
        body: uploadingMenu == true
            ? const LoadingDialogWidget(
                message: "Uploading menu ",
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(imageXfile!.path),
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.title,
                      color: Colors.blue.shade900,
                    ),
                    title: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: titleController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Menu title",
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.notes,
                      color: Colors.blue.shade900,
                    ),
                    title: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: aboutController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "About Menu",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        floatingActionButton: GestureDetector(
          onTap: () {
            uploadingMenu ? null : validateUploadForm();
          },
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlue,
            ),
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  clearAllDetails() {
    setState(() {
      titleController.clear();
      aboutController.clear();
      imageXfile = null;
      uploadingMenu = false;
    });
  }

  validateUploadForm() async {
    if (imageXfile != null) {
      if (titleController.text.isNotEmpty && aboutController.text.isNotEmpty) {
        setState(() {
          uploadingMenu = true;
        });
        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
        String? downloadUrl =
            await uploadImage(File(imageXfile!.path), uniqueName);

        saveInfoToFirestore(downloadUrl, uniqueName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) {
            return const ErrorDialogWidget(
              message: "Title and About is required", 
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return const ErrorDialogWidget(
            message: "Image is required",
          );
        },
      );
    }
  }

  Future<String> uploadImage(File mImageFile, String uniqueName) async {
    // print(userID);
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("menus");

    final storageRef.UploadTask uploadTask =
        reference.child("$uniqueName.jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    // print(downloadUrl);
    return downloadUrl;
  }

  saveInfoToFirestore(String downloadUrl, String uniqueName) {
    // print(userID);
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(userID)
        .collection("menus");
    ref.doc(uniqueName).set({
      "menuID": uniqueName,
      "sellerUID": userID,
      "title": titleController.text.toString(),
      "aboutMenu": aboutController.text.toString(),
      "status": "available",
      "publishedDate": DateTime.now(),
      "thumbnail": downloadUrl
    });

    clearAllDetails();
    setState(() {
      // uniqueName = "";
      uploadingMenu = false;
    });
  }
}
