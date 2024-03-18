import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderBoardTab extends StatelessWidget {
  final String profileIcon;
  final String username;
  final int points;

  const LeaderBoardTab({
    super.key,
    required this.profileIcon,
    required this.username,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF616161),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(profileIcon),
            backgroundColor: const Color(0xFFFF8159),
            radius: 30.0,
          ),
          const SizedBox(width: 10),
          Text(
            username,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                "$points",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Text(
                "points",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF8159),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
