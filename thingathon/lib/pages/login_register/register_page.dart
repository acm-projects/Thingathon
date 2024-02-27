import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thingathon/components/my_button.dart';
import 'package:thingathon/components/my_textfield.dart';
import 'package:thingathon/components/signin_button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? changePage;

  const RegisterPage({
    super.key,
    required this.changePage
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // User sign in method
  void signUp() {
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
                  hintText: "Phone number, email, or username",
                  obscureText: false,
                ),

                const SizedBox(height:10),

                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height:10),

                MyTextField(
                  controller: passwordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
            
                const SizedBox(height: 25),
            
                // Log in button
                MyButton(
                  buttonColor: const Color(0xFFFF8159),
                  text: "Sign Up",
                  onTap: signUp,
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
