import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/base_page/base_page.dart';
import '../pages/camera_page/home_page.dart';
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

// class Auth extends StatefulWidget {
//   const Auth({super.key});
//
//   @override
//   State<Auth> createState() => _AuthState();
// }
//
// class _AuthState extends State<Auth> {
//   bool loggedIn = false;
//
//   @override
//   Widget build(BuildContext context) {
//     if (loggedIn){
//       return const HomePage();
//     }
//
//     else{
//       return const LoginRegisterBuffer();
//     }
//   }
// }