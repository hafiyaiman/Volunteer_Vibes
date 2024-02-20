import 'package:flutter/material.dart';
import 'package:volunteer_vibes/widget/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();

  List<String> eventList = [
    'Join our gardening team in Pahang',
    'Gardeening helper',
    'Flood resque in Kelantan',
    'School Facilitators'
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(
        title: Text("Schedule"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.89,
          child: SingleChildScrollView(
            // Add this
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                        0.1), // Add your desired background color here
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Add border radius
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'Upcoming Event',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 200, // Adjust this value as needed
                  child: ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2, // Set the elevation as needed
                        margin:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                        child: ListTile(
                          title: Text(eventList[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
