// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfilePage extends StatelessWidget {
//   ProfilePage({super.key});
//
//   // Current logged in user
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//
//   // Future to fetch user details
//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
//     return await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(currentUser!.email)
//         .get();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         elevation: 0,
//       ),
//       body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         future: getUserDetails(),
//         builder: (context, snapshot) {
//           // loading
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           // error
//           else if (snapshot.hasError) {
//             return Text("Error: ${snapshot.error}");
//           }
//
//           // data recieved
//           else if (snapshot.hasData) {
//             //extract data
//             Map<String, dynamic>? user = snapshot.data!.data();
//             return Column(
//               children: [
//                 Text(user!['email']),
//                 Text(user['username']),
//               ],
//             );
//           } else {
//             return Text("No data");
//           }
//         },
//       ),
//     );
//   }
//
//   // State<ProfilePage> createState() => _ProfilePageState();
// }
// //
// // class _ProfilePageState extends State<ProfilePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFFf7f7f7),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();

            return Column(
              children: [
                Text(user!['email']),
                Text(user['username']),
              ],
            );
          } else {
            return const Text("No data");
          }
        },
      ),
    );
  }
}
