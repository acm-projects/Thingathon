import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thingathon/components/leaderboard_tab.dart';
import 'package:thingathon/components/my_button.dart';
import 'package:thingathon/helper/helper_functions.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int tappedIndex = 0;

  void changeLeaderBoard() {}

  @override
  Widget build(BuildContext context) {
    return (StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          displayMessageToUser("Something went wrong", context);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return const Text("No Data");
        }
        final users = snapshot.data!.docs;

        return (Center(
          child: Column(
            children: [
              const SizedBox(height: 51),
              Expanded(
                child: Container(
                  width: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.grey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MyButton(
                              buttonColor: tappedIndex == 0
                                  ? const Color(0xFFf7f7f7)
                                  : const Color(0xFFFF8159),
                              text: "Friends",
                              onTap: () {
                                setState(() {
                                  tappedIndex = 0;
                                });
                                changeLeaderBoard();
                              },
                              horizontalMargin: 10,
                            ),
                          ),
                          Expanded(
                            child: MyButton(
                              buttonColor: tappedIndex == 1
                                  ? const Color(0xFFf7f7f7)
                                  : const Color(0xFFFF8159),
                              text: "Global",
                              onTap: () {
                                setState(() {
                                  tappedIndex = 1;
                                });
                                changeLeaderBoard();
                              },
                              horizontalMargin: 10,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      LimitedBox(
                        maxHeight: 500,
                        child: Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return LeaderBoardTab(
                                profileIcon: "",
                                username: user["username"],
                                points: user["points"],
                              );
                            },
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    ));
  }
}
