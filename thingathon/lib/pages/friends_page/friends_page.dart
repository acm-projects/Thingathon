import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thingathon/components/profile_card.dart';
import 'package:thingathon/helper/helper_functions.dart';

FirebaseFirestore fs = FirebaseFirestore.instance;

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  Future<List<dynamic>> getCurrentPost() async {
    var posts = [];
    final userDocs = await fs.collection("Users").get();

    final usersWithImages = userDocs.docs.map((userDoc) {
      final userData = userDoc.data();
      final imagesRef = userDoc.reference.collection('Images');
      return {
        ...userData,
        'imagesRef': imagesRef,
      };
    }).toList();

    for (var userObject in usersWithImages) {
      var imageRef = userObject['imagesRef'];

      var imageDocs =
          await imageRef.where("isThingThere", isEqualTo: true).get();

      for (var docSnapshot in imageDocs.docs) {
        final imageURL = docSnapshot.data()['imageURL'];
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/${docSnapshot.id}';

        await Dio().download(imageURL, path);

        File imageFile = File(path);
        var updatedObject = {...userObject, 'imageFile': imageFile};
        posts.add(updatedObject);
      }
    }
    return posts;
  }

  @override
  void initState() {
    super.initState();
    getCurrentPost();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
                future: getCurrentPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var usersWithImages = snapshot.data!;
                    print(usersWithImages);

                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: 0.2),
                          physics: const BouncingScrollPhysics(),
                          itemCount: usersWithImages.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            var user = usersWithImages[index];
                            final imageProvider = FileImage(user["imageFile"]);

                            return ProfileCard(
                              profileIcon: imageProvider,
                              username: user["username"],
                              date: user["points"].toString(),
                              postImage: imageProvider,
                            );
                          }),
                    );
                  } else {
                   return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
