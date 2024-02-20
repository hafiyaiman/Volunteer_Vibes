import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:volunteer_vibes/controllers/MenuController.dart';
import 'package:volunteer_vibes/screens/admin/adm_activities_screen.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/adm_dashboard_screen.dart';
import 'package:volunteer_vibes/widget/responsive_widget.dart';
import 'package:volunteer_vibes/widget/side_bar.dart';

import '../../constants.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Initialize MenuController
    MenuControllers menuController = Provider.of<MenuControllers>(context);

    // Set the scaffold key in MenuController
    menuController.setScaffoldKey(_key);

    return ChangeNotifierProvider(
      create: (context) => menuController,
      child: Scaffold(
        key: _key,
        drawer: HSidebarX(controller: _controller),
        body: Row(
          children: [
            if (!ResponsiveWidget.isSmallScreen(context))
              HSidebarX(controller: _controller),
            Expanded(
              child: Material(
                child: ScreensExample(
                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreensExample extends StatelessWidget {
  const ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return DashboardScreen();
          case 1:
            return ActivitiesScreen();
          
          default:
            return Text(
              pageTitle,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key;

  const Header({
    required GlobalKey<ScaffoldState> key,
  })  : _key = key,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!ResponsiveWidget.isLargeScreen(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState?.openDrawer();
            },
          ),
        if (!ResponsiveWidget.isSmallScreen(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!ResponsiveWidget.isSmallScreen(context))
          Spacer(flex: ResponsiveWidget.isLargeScreen(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard(),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.network(
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
            height: 38,
          ),
          if (!ResponsiveWidget.isSmallScreen(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Angelina Jolie"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(Iconsax.search_normal),
          ),
        ),
      ),
    );
  }
}

void Logout() {
  FirebaseAuth.instance.signOut();
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
