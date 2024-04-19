import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  static Future<bool> uploadImage(XFile imageFile, String userEmail) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesFolderRef = storageRef.child("images").child(userEmail);

    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final userImageRef = imagesFolderRef.child(currentTime);

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.month, now.day);
    
    String currentObj = "dog";

    print(currentDate);

    try {
      await userImageRef.putFile(File(imageFile.path));
      String imageURL = await userImageRef.getDownloadURL();
      final userDoc =
          FirebaseFirestore.instance.collection("Users").doc(userEmail);

      await userDoc
          .collection("Images")
          .doc(currentTime)
          .set({'imageURL': imageURL, 'postDate': currentDate, 'thing': currentObj});

      await userDoc.get().then((value) {
        if (value.data() != null) {
          if (value.data()!['points'] == null) {
            userDoc.update({'points': 0});
          }
        }
      });

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        var snapshot = await transaction.get(userDoc);
        final newPoints = snapshot.get("points") + 100;
        transaction.update(userDoc, {'points': newPoints});
      });

      return true;
    } catch (e) {
      print(e);
    }

    return false;
  }
}
