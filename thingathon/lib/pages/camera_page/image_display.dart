import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:thingathon/components/my_button.dart';
import 'package:thingathon/database/fire_storage.dart';
import 'package:thingathon/pages/base_page/base_page.dart';

class ImageDisplay extends StatelessWidget {
  final XFile imageFile;
  const ImageDisplay({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    void submitImage() async {
      String? userEmail;
      User? user = FirebaseAuth.instance.currentUser;
      bool correctImage = false;

      if (user != null) {
        userEmail = user.email;
      } else {
        userEmail = null;
      }

      if (userEmail != null) {
        correctImage = await FireStorage.uploadImage(imageFile, userEmail);

        // if (correctImage && context.mounted) {
        //   Get.to(const BasePage());
        // }
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFf7f7f7),
          title: Image.asset(
            'assets/Thingathon.png',
            width: 150,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              color: const Color(0xFFf7f7f7),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      child: Image.file(File(imageFile.path), fit: BoxFit.fill),
                    ),
                  ),
                  MyButton(
                      buttonColor: const Color(0xFFFF8159),
                      text: "Submit",
                      onTap: submitImage,
                      horizontalMargin: 50),
                ],
              ),
            ),
          ),
        ));
  }
}
