import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thingathon/components/dialog_popup.dart';
import 'package:thingathon/helper/helper_functions.dart';

FirebaseFirestore fs = FirebaseFirestore.instance;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay; // update `_focusedDay` here as well
      });

      String userEmail = getUserEmail();
      final imageCollection =
          await fs.collection("Users").doc(userEmail).collection("Images");

      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(selectedDay);

      var imageDocs = await imageCollection
          .where('postDate', isEqualTo: formattedDate)
          .get();

      print(imageDocs.docs);

      if (imageDocs.docs.isNotEmpty) {
        var docSnapshot = imageDocs.docs[0];
        final imageURL = docSnapshot.data()['imageURL'];
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/${docSnapshot.id}';

        await Dio().download(imageURL, path);

        File imageFile = File(path);

        Get.to(PhotoExample(
          date: formattedDate,
          postImage: FileImage(imageFile),
        ));
      } else {
        Get.dialog(const DialogPopup(text1: "Alert", text2: "No posts for this date", text3: "Sounds good!"));
      }

      //Get.to(PhotoExample(date: selectedDay));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom header with BoxDecoration and circular edges
          const SizedBox(height: 10),
          SafeArea(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: HeaderStyle(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8159),
                  borderRadius: BorderRadius.circular(60),
                ),
                formatButtonVisible: false,
                titleCentered: true,
              ), // Hide default header
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xFFFF8159),
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekHeight: 40,
              rowHeight: 80,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Color(0xFF000000)),
                weekendStyle: TextStyle(color: Color(0xFF000000)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoExample extends StatelessWidget {
  final String date;
  final FileImage postImage;

  const PhotoExample({Key? key, required this.date, required this.postImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8159),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Thingathon.png',
              height: 40,
            ),
            const SizedBox(
                width: 30), // Add some space between the logo and the text
            Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: postImage,
          ),
        ),
      ),
    );
  }
}
