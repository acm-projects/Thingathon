import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thingathon/auth/auth.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  // Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Thingathon',
        home: Auth(),
    );
  }
}
