import 'package:flutter/material.dart';
import 'package:thingathon/components/bottom_navbar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Calendar Page"),
      bottomNavigationBar: NavBar(),
    );
  }
}