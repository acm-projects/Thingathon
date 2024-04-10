import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/empty_avatar.png'),
                  radius: 20.0,
                ),
                Text(
                  "@balebbae",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "100006 points",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/empty_profile.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "@balebbae",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "100006 points",
                    style: TextStyle(fontSize: 22.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Image.asset('assets/empty_icon.png'), onPressed: () {}),
            IconButton(icon: Image.asset('assets/empty_icon.png'), onPressed: () {}),
            IconButton(icon: Image.asset('assets/empty_icon.png'), onPressed: () {}),
            IconButton(icon: Image.asset('assets/empty_icon.png'), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
