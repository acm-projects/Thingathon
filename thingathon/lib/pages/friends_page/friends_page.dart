import 'package:flutter/material.dart';
import 'package:thingathon/components/bottom_navbar.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Friend Page"),
      bottomNavigationBar: NavBar(),
    );
  }
}