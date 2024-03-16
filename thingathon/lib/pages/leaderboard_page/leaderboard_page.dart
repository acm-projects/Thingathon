import 'package:flutter/material.dart';
import 'package:thingathon/components/bottom_navbar.dart';
import 'package:thingathon/components/my_button.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  void changeLeaderBoard() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                MyButton(
                    buttonColor: const Color(0xFFFF8159),
                    text: "Friends",
                    onTap: changeLeaderBoard),
                MyButton(
                    buttonColor: const Color(0xFFf7f7f7),
                    text: "Global",
                    onTap: changeLeaderBoard)
              ],
            ),
            const Column(
              children: [],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
