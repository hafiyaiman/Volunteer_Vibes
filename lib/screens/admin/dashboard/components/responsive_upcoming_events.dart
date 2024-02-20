import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/adm_dashboard_screen.dart';
import 'package:volunteer_vibes/widget/responsive_widget.dart';

import '../../../../constants.dart'; // Import your UpcomingEventsList widget

class ResponsiveUpcomingEvents extends StatelessWidget {
  final DateTime _focusedDay;
  final CalendarFormat _calendarFormat;
  List<String> upcomingEvents = ['Event 1', 'Event 2', 'Event 3'];

  ResponsiveUpcomingEvents({
    required DateTime focusedDay,
    required CalendarFormat calendarFormat,
  })  : _focusedDay = focusedDay,
        _calendarFormat = calendarFormat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  UpcomingEventsList(upcomingEvents: upcomingEvents),
                  SizedBox(height: 20),
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingEventsList extends StatelessWidget {
  final List<String> upcomingEvents;

  UpcomingEventsList({required this.upcomingEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: upcomingEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(upcomingEvents[index]),
          // Add more details or customize as needed
        );
      },
    );
  }
}
