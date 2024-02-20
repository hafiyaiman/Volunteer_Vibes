import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:volunteer_vibes/constants.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/components/line_chart.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/components/my_fields.dart';

import 'components/header.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: SafeArea(
            child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Header(),
                  SizedBox(height: defaultPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MyFiles(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          width: 650,
                          decoration: BoxDecoration(
                            color:
                                secondaryColor, // Add your desired background color here
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
                              setState(() {
                                _focusedDay = focusedDay;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 380,
                        width: 650,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView(
                            scrollDirection: Axis
                                .vertical, // Set the scroll direction to vertical
                            children: <Widget>[
                              SizedBox(
                                height:
                                    10, // Use height instead of width for vertical spacing
                              ),
                              Container(
                                child: Text("Volunteer Activities"),
                                height:
                                    160, // Change width to height for vertical containers
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text("Volunteer Activities"),
                                height: 160,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text("Volunteer Activities"),
                                height: 160,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text("Volunteer Activities"),
                                height: 160,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text("Volunteer Activities"),
                                height: 160,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
