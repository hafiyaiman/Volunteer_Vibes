import 'package:firebase_auth/firebase_auth.dart';

import 'package:iconsax/iconsax.dart';


import 'package:volunteer_vibes/controllers/MenuController.dart';


import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';


import 'package:provider/provider.dart';


import 'package:volunteer_vibes/widget/responsive_widget.dart';


import '../../../../constants.dart';


class Header extends StatelessWidget {

  const Header({

    Key? key,

  }) : super(key: key);


  @override

  Widget build(BuildContext context) {

    return Row(

      children: [

        if (!ResponsiveWidget.isLargeScreen(context))

          IconButton(

            icon: Icon(Icons.menu),


            //open side bar


            onPressed: () {

              context.read<MenuControllers>().openDrawer();

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

        ProfileCard()

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

              child: Text("Hafiy Aiman"),

            ),

          PopupMenuButton<String>(

            icon: Icon(Icons.keyboard_arrow_down),

            onSelected: (value) {

              if (value == 'logout') {

                FirebaseAuth.instance.signOut();

              }

            },

            itemBuilder: (BuildContext context) {

              return [

                PopupMenuItem<String>(

                  value: 'logout',

                  child: ListTile(

                    leading: Icon(Icons.exit_to_app),

                    title: Text('Logout'),

                  ),

                ),

              ];

            },

          ),

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

