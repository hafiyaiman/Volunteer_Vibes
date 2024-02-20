import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:volunteer_vibes/app_color.dart';
import 'package:volunteer_vibes/screens/admin/adm_activities_screen.dart';

class HSidebarX extends StatelessWidget {
  const HSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.darkBackColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Color(0xFF464667),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.darkBackColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF5F5FA7).withOpacity(0.6).withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF3E3E61), AppColors.darkBackColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.darkBackColor,
        ),
      ),
      footerDivider: Divider(color: Colors.white.withOpacity(0.3), height: 1),
      headerBuilder: (context, extended) {
        return const SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            // child: Image.asset('assets/images/avatar.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Iconsax.category5,
          label: 'Dashboard',
          onTap: () {
            debugPrint('Dashboard');
          },
        ),
        SidebarXItem(
          icon: Iconsax.calendar5,
          label: 'Activities',
          onTap: () {
            debugPrint('Dashboard');
          },
        ),
        const SidebarXItem(
          icon: Iconsax.people5,
          label: 'Participants',
        ),
        SidebarXItem(
          icon: Iconsax.graph5,
          label: 'Report',
          onTap: () {},
        ),
        const SidebarXItem(
          icon: Iconsax.discount_shape5,
          label: 'Message',
        ),
        const SidebarXItem(
          icon: Iconsax.setting_5,
          label: 'Settings',
        ),
        
      ],
    );
  }
}
