import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay; // update `_focusedDay` here as well
      });

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoExample(date: selectedDay)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom header with BoxDecoration and circular edges
          Container(
            // decoration: BoxDecoration(
            //   color: Color(0xFFFF8159), // Background color of the header
            //   borderRadius: BorderRadius.all(Radius.circular(40)),
            // ),
            //padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
            ),
          ),
          TableCalendar(
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
                color: Color(0xFFFF8159),
                borderRadius: BorderRadius.circular(60),
              ),
              formatButtonVisible: false,
              titleCentered: true,
            ), // Hide default header
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Color(0xFFFF8159),
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekHeight: 40,
            rowHeight: 95,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: const TextStyle(color: Color(0xFF000000)),
              weekendStyle: const TextStyle(color: Color(0xFF000000)),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoExample extends StatelessWidget {
  final DateTime date;

  const PhotoExample({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF8159),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            SizedBox(width: 30), // Add some space between the logo and the text
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(
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
            image: AssetImage('assets/MukPFP.jpg'),
          ),
          
        ),
      ),
    );
  }
}
