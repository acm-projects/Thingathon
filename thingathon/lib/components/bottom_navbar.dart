import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// Brute force way of having the selector bar pop up on each icon
//  -Have tap variable for each icon and set the state of all of them depending on which is pressed

const Color navBarColor = Color.fromARGB(255, 45, 45, 45);

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int tappedIconIndex = 2;

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIconIndex = 0;
                  });
                },
                child: NavBarIcon(
                  iconSize: 30,
                  icon: FontAwesomeIcons.chartSimple,
                  index: 0,
                  selectedIndex: tappedIconIndex,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIconIndex = 1;
                  });
                },
                child: NavBarIcon(
                  iconSize: 30,
                  icon: FontAwesomeIcons.userGroup,
                  index: 1,
                  selectedIndex: tappedIconIndex,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIconIndex = 2;
                  });
                },
                child: NavBarIcon(
                  iconSize: 30,
                  icon: FontAwesomeIcons.circle,
                  index: 2,
                  selectedIndex: tappedIconIndex,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIconIndex = 3;
                  });
                },
                child: NavBarIcon(
                  iconSize: 30,
                  icon: FontAwesomeIcons.calendar,
                  index: 3,
                  selectedIndex: tappedIconIndex,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIconIndex = 4;
                  });
                },
                child: NavBarIcon(
                  iconSize: 30,
                  icon: FontAwesomeIcons.solidUser,
                  index: 4,
                  selectedIndex: tappedIconIndex,
                ),
              ),
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
      height: 8,
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
  final int index;
  final int selectedIndex;

  const NavBarIcon({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.index,
    required this.selectedIndex,
  });

  @override
  State<NavBarIcon> createState() => _NavBarIconState();
}

class _NavBarIconState extends State<NavBarIcon> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.selectedIndex == widget.index
            ? TopBar(tapped: true)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        Container(
          height: 50,
          child: Icon(
            widget.icon,
            size: widget.iconSize,
            color: const Color(0xFFf7f7f7),
          ),
        ),
      ],
    );
  }
}
