import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// Brute force way of having the selector bar pop up on each icon 
//  -Have tap variable for each icon and set the state of all of them depending on which is pressed

const Color navBarColor = Color.fromARGB(255, 45, 45, 45);

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.1,
      child: Container(
        decoration: BoxDecoration(
          color: navBarColor.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: navBarColor.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavBarIcon(iconSize: 30, icon: FontAwesomeIcons.chartSimple),
              Spacer(),
              NavBarIcon(iconSize: 30, icon: FontAwesomeIcons.userGroup),
              Spacer(),
              NavBarIcon(iconSize: 40, icon: FontAwesomeIcons.circle),
              Spacer(),
              NavBarIcon(iconSize: 30, icon: FontAwesomeIcons.calendar),
              Spacer(),
              NavBarIcon(iconSize: 30, icon: FontAwesomeIcons.solidUser),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final bool tapped;
  const TopBar({
    super.key,
    required this.tapped,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: tapped ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFFFF8159),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class NavBarIcon extends StatefulWidget {
  final IconData icon;
  final double iconSize;

  const NavBarIcon({
    super.key,
    required this.icon,
    required this.iconSize,
  });

  @override
  State<NavBarIcon> createState() => _NavBarIconState();
}

class _NavBarIconState extends State<NavBarIcon> {
  bool tapped = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        tapped
            ? TopBar(tapped: tapped)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        GestureDetector(
          onTap: () {
            setState(() {
              tapped = !tapped;
            });
          },
          child: SizedBox(
            height: 60,
            child: Icon(
              widget.icon,
              size: widget.iconSize,
              color: const Color(0xFFf7f7f7),
            ),
          ),
        ),
      ],
    );
  }
}
