import 'package:flutter/material.dart';


import 'package:volunteer_vibes/constants.dart';


class CloudStorageInfo {

  final IconData? iconData;


  final String? title;


  final String? totalStorage;


  final int? percentage;


  final Color? color;


  CloudStorageInfo({

    this.iconData,

    this.title,

    this.totalStorage,



    this.percentage,

    this.color,

  });

}


List<CloudStorageInfo> demoMyFiles = [

  CloudStorageInfo(

    title: "Total Events",




    iconData: Icons.event, // Replace with your desired Flutter Icon


    totalStorage: "100",


    color: primaryColor,


    percentage: 35,

  ),

  CloudStorageInfo(

    title: "Volunteer Volunteered",




    iconData: Icons.people, // Replace with your desired Flutter Icon


    totalStorage: "589",


    color: Color(0xFFFFA113),


    percentage: 35,

  ),

  CloudStorageInfo(

    title: "Total Hours",





    iconData: Icons.access_time, // Replace with your desired Flutter Icon


    totalStorage: "30",


    color: Color(0xFFA4CDFF),


    percentage: 10,

  ),

  CloudStorageInfo(

    title: "Unread Notifications",

    totalStorage: "0",


    iconData: Icons.notifications, // Replace with your desired Flutter Icon


    color: Color(0xFF007EE5),


    percentage: 78,

  ),

];

