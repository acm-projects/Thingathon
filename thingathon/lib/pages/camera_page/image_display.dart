import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thingathon/components/my_button.dart';

class ImageDisplay extends StatelessWidget {
  final File imageFile;
  const ImageDisplay({super.key, required this.imageFile});

  void submitImage() {
    
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      child: Image.file(imageFile, fit: BoxFit.fill),
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
