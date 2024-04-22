import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatefulWidget {
  final String username;
  final String date;
  final FileImage profileIcon;
  final FileImage postImage;
  const ProfileCard(
      {super.key,
      required this.username,
      required this.date,
      required this.postImage,
      required this.profileIcon});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 23,
              //backgroundImage: ,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFFF8159))),
                      const SizedBox(width: 150),
                      Expanded(
                        child: Text('${widget.date} Points',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 34, 34, 34),
                                fontWeight: FontWeight.w700)),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  Image(
                    image: widget.postImage,
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
