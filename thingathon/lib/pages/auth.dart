import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thingathon/pages/login_register/login_register_buffer.dart';
import 'home_page.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (loggedIn){
      return HomePage();
    }

    else{
      return LoginRegisterBuffer();
    }
  }
}