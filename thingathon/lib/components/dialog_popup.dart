import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogPopup extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  const DialogPopup({super.key, required this.text1, required this.text2, required this.text3});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFF8159),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 75.0,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text1,
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                text2,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    foregroundColor: Color(0xFFFF8159),
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(text3))
            ],
          ),
        ),
      ),
    );
  }
}
