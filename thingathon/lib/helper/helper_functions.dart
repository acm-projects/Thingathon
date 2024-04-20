import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

String getUserEmail() {
  String userEmail;
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    userEmail = user.email!;
  } else {
    userEmail = "";
  }

  return userEmail;
}
