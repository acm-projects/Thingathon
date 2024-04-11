import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String username;
  Timestamp createdOn;
  Timestamp updatedOn;

  User({
    required this.email,
    required this.username,
    required this.createdOn,
    required this.updatedOn,
  });
}
