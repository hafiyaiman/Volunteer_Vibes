import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:volunteer_vibes/screens/volunteer/vltr_activities_screen.dart';
import 'package:volunteer_vibes/screens/volunteer/vltr_calendar_screen.dart';

import 'package:volunteer_vibes/screens/volunteer/vltr_home_screen.dart';
import 'package:volunteer_vibes/screens/volunteer/vltr_profile_screen.dart';

class HNavBar extends StatefulWidget {
  @override
  _HNavBarState createState() => _HNavBarState();
}

class _HNavBarState extends State<HNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ActivitiesScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIconWithBoldText(IconData iconData, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: isSelected ? Colors.blue : Colors.grey,
          size: 30,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIconWithBoldText(Iconsax.home, _selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithBoldText(Iconsax.activity, _selectedIndex == 1),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon:
                _buildIconWithBoldText(Iconsax.calendar_1, _selectedIndex == 2),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithBoldText(
                Iconsax.profile_circle4, _selectedIndex == 3),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
