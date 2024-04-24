import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

int points = 100000;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF8159),
                borderRadius: BorderRadius.circular(
                    25.0), // This adds the rounded corners.
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: const CircleAvatar(
                      backgroundImage: const AssetImage('assets/MukPFP.jpg'),
                      radius: 20.0,
                    ),
                  ),
                  const SizedBox(
                      width:
                          16.0), // Spacer can be replaced with a SizedBox for precise control.
                  const Text(
                    "@muktheduck",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    // This makes the text widget take all available space.
                    child: Container(),
                  ),
                  Text(
                    points.toString(),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/MukPFP.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "@balebbae",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    points.toString(),
                    style: const TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    buttonColor: const Color(0xFFFF8159),
                    text: "Sign Out",
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    horizontalMargin: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
