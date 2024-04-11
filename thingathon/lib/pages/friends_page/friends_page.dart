import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thingathon/components/profile_card.dart';
import 'package:thingathon/helper/helper_functions.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
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
          for(int i = 0; i < users.length; i++){
            var user = users[i];
            print(user.reference.collection("Images").get());
          }

          return Scaffold(
            body: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 0.2),
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
            
                  return;
                  // user.collection("Images");
                  // return ProfileCard(
                  //   profileIcon: "",
                  //   username: user["username"],
                  //   date: user["points"],
                  //   postImage: "",
                  // );
                }),
          );
        }));
  }
}
