import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 230, 230, 230)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Color.fromARGB(255, 192, 192, 192),
            fontSize: 12,
          ),
          labelStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.amber),
        ),
      ),
    );
  }
}
