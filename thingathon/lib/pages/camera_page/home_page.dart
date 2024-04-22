import 'package:flutter/material.dart';
import 'package:thingathon/pages/camera_page/photo_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Expanded(
        child: PhotoScreen(),
      ),
    );
  }
}

// TEST

