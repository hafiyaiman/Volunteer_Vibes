import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:volunteer_vibes/screens/admin/adm_main_screen.dart';

import 'package:volunteer_vibes/screens/login_screen.dart';
import 'package:volunteer_vibes/widget/nav_bar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in, check user role in Firestore
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  // Loading state
                  return CircularProgressIndicator();
                } else if (userSnapshot.hasError) {
                  // Error state
                  return Text('Error loading user data');
                } else if (!userSnapshot.hasData ||
                    !userSnapshot.data!.exists) {
                  // User document not found
                  return Text('User document not found');
                } else {
                  // User role found in Firestore
                  String userRole = userSnapshot.data!['role'];
                  if (userRole == 'admin') {
                    // Redirect to the admin screen
                    return MainScreen();
                  } else {
                    // Redirect to the regular user screen
                    return HNavBar();
                  }
                }
              },
            );
          } else {
            // User is not logged in
            return LoginScreen();
          }
        },
      ),
    );
  }



  authorizeAccess(BuildContext context) {}

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
