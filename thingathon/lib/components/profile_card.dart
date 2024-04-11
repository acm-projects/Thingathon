import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thingathon/schema/user.dart';

class ProfileCard extends StatefulWidget {
  final String username;
  final String date;
  final Image profileIcon;
  final Image postImage;
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
            CircleAvatar(
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
                              color: Colors.white)),
                      const SizedBox(width: 1.5),
                      Expanded(
                        child: Text('@${widget.date}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  //Image(image: image)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
