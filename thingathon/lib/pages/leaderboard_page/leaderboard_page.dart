import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thingathon/components/bottom_navbar.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Leaderboard Page"),
      bottomNavigationBar: NavBar(),
    );
  }
}