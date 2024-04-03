import 'package:flutter/material.dart';
import 'package:thingathon/pages/camera_page/photo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Container(
          child: PhotoScreen(),
        ),
      ),
    );
  }
}

// TEST

