import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:volunteer_vibes/app_color.dart';
import 'package:volunteer_vibes/screens/volunteer/vltr_chat_screens';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();

  List<String> eventList = [
    'Event 1',
    'Event 2',
    'Event 3',
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.4,
              width: width,
              color: AppColors.primary,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Title in the top left corner
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Home',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(), // Spacer to push the button to the right
                              // Button in the top right corner
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Iconsax.message5,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatPage()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Add the ListView here
                  Container(
                    height: height * 0.2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.secGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.secGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.secGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.secGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.secGreyColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Upcoming Events",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 22.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
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
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Discover",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 22.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            // Add the ListView here
            Container(
              height: height * 0.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
