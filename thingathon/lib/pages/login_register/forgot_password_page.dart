import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/my_textfield.dart';
import '../../helper/helper_functions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});


  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.pop(context);
      // Display Error message to user
      displayMessageToUser(e.code, context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8159),
        elevation: 0,
      ),
      body: Column(
        children: [
          const Text('Enter Your Email and we will send you a password reset link.'),
          MyTextField(
            controller: emailController,
            hintText: "email",
            obscureText: false,
          ),
          MaterialButton(
            onPressed: passwordReset,
            color: const Color(0xFFFF8159),
            child: const Text("Reset Password"),
          ),
        ],
      ),
    );
  }
}
