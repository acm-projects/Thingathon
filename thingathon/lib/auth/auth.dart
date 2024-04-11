import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/base_page/base_page.dart';
import 'login_register_buffer.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Use is logged in
          if (snapshot.hasData) {
            return const BasePage();
          }

          // User is NOT logged in
          else {
            return const LoginRegisterBuffer(); ///Error here
          }
        },
      ),
    );
  }
}