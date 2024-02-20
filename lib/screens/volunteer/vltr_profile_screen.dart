import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:volunteer_vibes/app_color.dart';
import 'package:volunteer_vibes/screens/auth_screen.dart';
import 'package:volunteer_vibes/widget/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? phoneNumber;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is signed in
    if (user != null) {
      // Access Firestore and retrieve user data based on the user ID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      // Check if the user document exists
      if (userSnapshot.exists) {
        // Access the user data
        setState(() {
          name = userSnapshot.data()?['name'];
          phoneNumber = userSnapshot.data()?['mobile'];
          email = userSnapshot.data()?['email'];
        });
      } else {
        // Handle the case where the user document does not exist
        print("User document does not exist.");
      }
    } else {
      // Handle the case where the user is not signed in
      print("User not signed in.");
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HAppBar(
        title: const Text('Profile'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: signout,
                icon: const Icon(
                  Iconsax.logout,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name ?? '',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        phoneNumber ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                AppColors.secGreyColor.withOpacity(0.1),
                            padding: EdgeInsets.zero,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: const ListTile(
                            title: Text('My Account',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            trailing:
                                Icon(Iconsax.arrow_right_3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                AppColors.secGreyColor.withOpacity(0.1),
                            padding: EdgeInsets.zero,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: const ListTile(
                            title: Text('Settings',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            trailing:
                                Icon(Iconsax.arrow_right_3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                AppColors.secGreyColor.withOpacity(0.1),
                            padding: EdgeInsets.zero,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: const ListTile(
                            title: Text('Change Password',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            trailing:
                                Icon(Iconsax.arrow_right_3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                AppColors.secGreyColor.withOpacity(0.1),
                            padding: EdgeInsets.zero,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: const ListTile(
                            title: Text('About Us',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            trailing:
                                Icon(Iconsax.arrow_right_3, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              //Circle Avatar
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: -75,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
