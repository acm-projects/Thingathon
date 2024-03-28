import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/signin_button.dart';
import '../../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final Function()? changePage;

  const RegisterPage({super.key, required this.changePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // User sign in method ------USER AUTH----------
 void signUp() async {
   // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
    );

    // make sure passwords match
    if(passwordController.text != confirmPwController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error
      displayMessageToUser("Passwords don't match!", context);
    }

    // If passwords do match
    else {
      // try creating the user
      try {
        // create User
        UserCredential? userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
        // Create a user document and add to firestore
        createUserDocument(userCredential);

        // pop loading circle
        if (context.mounted)Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop Loading Circle
        if (context.mounted) Navigator.pop(context);
        // Display Error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

 // Create a user document and collect them in Firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
   if (userCredential != null && userCredential.user != null) {
     await FirebaseFirestore.instance
         .collection("Users")
         .doc(userCredential.user!.email)
         .set({
       'email': userCredential.user!.email,
       'username': usernameController.text,
     });
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Thingathon logo
                Image.asset(
                  'assets/Thingathon.png',
                  width: 200,
                  height: 100,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 15),

                // Welcome text
                Text(
                  "Lets get signed up!",
                  style: GoogleFonts.poppins(
                      color: const Color(0xFFFF8159),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),

                const SizedBox(height: 30),

                // Input Fields
                MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: confirmPwController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // Log in button
                MyButton(
                  buttonColor: const Color(0xFFFF8159),
                  text: "Sign Up",
                  onTap: signUp,
                  horizontalMargin: 40,
                ),

                const SizedBox(height: 20),

                // "OR" screen divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        "OR",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF616161),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // "Continue with" buttons
                const SignInButton(
                  text: "Continue with Apple",
                  fontAwesomeIcon: FontAwesomeIcons.apple,
                ),
                const SignInButton(
                  text: "Continue with Google",
                  fontAwesomeIcon: FontAwesomeIcons.google,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 58, 58, 58)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    GestureDetector(
                      onTap: widget.changePage,
                      child: Text(
                        "Login now",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
