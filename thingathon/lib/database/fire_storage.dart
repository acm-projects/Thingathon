import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class FireStorage {
  static Future<bool> uploadImage(XFile imageFile, String userEmail) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesFolderRef = storageRef.child("images").child(userEmail);

    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final userImageRef = imagesFolderRef.child(currentTime);

    var now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String currentObj = "dog";

    // Post Request to endpoint
    // Dio dio = new Dio();
    bool correctObject = true;
    // const String endPoint = "";

    // var imageBytes = await imageFile.readAsBytes();
    // var base64img = base64Encode(imageBytes);

    // Response res = await dio.post(endPoint, data: {'base64img': base64img});

    // print(res.data);

    // End of Post Request

    // If the object is correct then upload to fireStore
    if (correctObject) {
      try {
        await userImageRef.putFile(File(imageFile.path));
        String imageURL = await userImageRef.getDownloadURL();
        final userDoc =
            FirebaseFirestore.instance.collection("Users").doc(userEmail);

        await userDoc.collection("Images").doc(currentTime).set({
          'imageURL': imageURL,
          'postDate': formattedDate,
          'thing': currentObj
        });

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
    }
    return false;
  }
}
