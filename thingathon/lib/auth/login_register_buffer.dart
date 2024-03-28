import 'package:flutter/cupertino.dart';
import 'package:thingathon/pages/login_register/login_page.dart';
import 'package:thingathon/pages/login_register/register_page.dart';

class LoginRegisterBuffer extends StatefulWidget {
  const LoginRegisterBuffer({super.key});

  @override
  State<LoginRegisterBuffer> createState() => _LoginRegisterBufferState();
}

class _LoginRegisterBufferState extends State<LoginRegisterBuffer> {

  bool loginPage = true;

  void togglePages(){
    setState(() {
      loginPage = !loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginPage){
      return LoginPage(changePage: togglePages);
    } else {
      return RegisterPage(changePage: togglePages);
    }
  }
}