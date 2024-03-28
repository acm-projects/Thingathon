/*

This database stores images taken by the user after it is verified to be the object.
It is stored in a collection called 'Posts' in Firebase

Each post contains;
- timestamp
- username

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current logged in user
  User? user = FirebaseAuth.instance.currentUser;
  // get collection of posts from firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
  // read posts from database
  Future<void> addPost(String photo) {
    return posts.add({
      'UserEmail' : user!.email,
      'PostPhoto' : photo,
      'TimeStamp' : Timestamp.now(),
    });
  }
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postsStream;
  }
}