import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:volunteer_vibes/app_color.dart';
import 'package:volunteer_vibes/app_style.dart';
import 'package:volunteer_vibes/screens/admin/adm_main_screen.dart';
import 'package:volunteer_vibes/screens/register_volunteer.dart';
import 'package:volunteer_vibes/screens/volunteer/vltr_home_screen.dart';
import 'package:volunteer_vibes/services/auth_service.dart';
import 'package:volunteer_vibes/widget/nav_bar.dart';
import 'package:volunteer_vibes/widget/responsive_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editing controller
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // Initially password is obscure
  bool _obscureText1 = true;

  String _password = '';

  // Toggles the password show status
  void _pass1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  //sign user in method
  signUserIn() async {
    //show loading screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      //pop the loading screen
      Navigator.pop(context);

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
          // Access the 'name' field in the user document
          String? role = userSnapshot.data()?['role'];

          if (role == 'volunteer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HNavBar(),
              ),
            );
          } else {
            // Navigate to a different screen for users with roles other than 'volunteer'
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      //pop the loading screen
      Navigator.pop(context);
      //wrong email
      print(e.toString());

      if (e.code == 'INVALID_LOGIN_CREDENTIALS' ||
          e.code == 'channel-error' ||
          e.code == 'invalid-credential') {
        print("invalid email and password");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid email or password"),
          ),
        );
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  void wrongPassMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  Future<String?> getUserRole() async {
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
        // Access the 'name' field in the user document
        String? role = userSnapshot.data()?['role'];

        // Return the user's name
        return role;
      } else {
        // Handle the case where the user document does not exist
        print("User document does not exist.");
        return null;
      }
    } else {
      // Handle the case where the user is not signed in
      print("User not signed in.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: AppColors.backColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //------ CONTAINER LEFT ----------//
                      ResponsiveWidget.isSmallScreen(context)
                          ? const SizedBox()
                          : Expanded(
                              child: Container(
                                height: height,
                                color: AppColors.primary,
                                child: Center(
                                  child: Text(
                                    'VolunteerVibes',
                                    style: ralewayStyle.copyWith(
                                      fontSize: 48.0,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      //------ CONTAINER RIGHT ----------//
                      Expanded(
                        child: Container(
                          height: height,
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  ResponsiveWidget.isSmallScreen(context)
                                      ? height * 0.032
                                      : height * 0.12),
                          //color: AppColors.backColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.2),
                              //------ TITLE LOGIN ----------//
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Let's",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' Sign In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                'Hey! Enter your details to get sign in \nto your account.',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              SizedBox(height: height * 0.064),

                              const SizedBox(height: 6.0),
                              //-------- EMAIL TEXT BOX ----------//
                              SizedBox(
                                height: 50.0,
                                width: width,
                                child: TextFormField(
                                  controller: emailController,
                                  style: ralewayStyle.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                  decoration: InputDecoration(
                                    // minit ke 8
                                    prefixIcon: const Icon(
                                      Icons.alternate_email_outlined,
                                    ),
                                    // contentPadding:
                                    //     const EdgeInsets.only(top: 16.0),
                                    labelText: 'Email',

                                    hintStyle: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blueDarkColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.014),

                              const SizedBox(height: 6.0),
                              //-------- PASSWORD TEXT BOX ----------//

                              SizedBox(
                                height: 50.0,
                                width: width,
                                child: TextFormField(
                                  controller: passController,
                                  style: ralewayStyle.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    // minit ke 8
                                    suffixIcon: IconButton(
                                      onPressed: _pass1,
                                      icon: _obscureText1
                                          ? const Icon(Iconsax.eye)
                                          : const Icon(Iconsax.eye_slash),
                                    ),
                                    prefixIcon: const Icon(Icons.lock_outline),
                                  ),
                                  validator: (val) => val!.length < 6
                                      ? 'Password too short.'
                                      : null,
                                  onSaved: (val) => _password = val!,
                                  obscureText: _obscureText1,
                                ),
                              ),
                              SizedBox(height: height * 0.005),
                              //-------- LINK FORGOT PASSWORD ----------//
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.05),
                              //-------- BUTTON SIGN IN ----------//
                              Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: signUserIn,
                                    borderRadius: BorderRadius.circular(32.0),
                                    child: Ink(
                                      width: ResponsiveWidget.isSmallScreen(
                                              context)
                                          ? width / 2
                                          : width / 4,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        color: const Color.fromARGB(
                                            255, 17, 96, 200),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Sign In',
                                          style: ralewayStyle.copyWith(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              //-------- DIVIDER OR ----------//
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Divider(
                                    color: AppColors.greyColor,
                                    indent: height * 0.06,
                                    endIndent: height * 0.01,
                                  )),
                                  Text(
                                    "OR",
                                    style: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.greyColor,
                                      indent: height * 0.01,
                                      endIndent: height * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              //-------- BUTTON SIGN IN GOOGLE ----------//
                              Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? width / 1.5
                                            : width / 4,
                                    child: OutlinedButton(
                                      onPressed: AuthService().signInWithGoogle,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/google_icon.svg',
                                              width: 50.0),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 14.0,
                                            ),
                                            child: Text(
                                              'Sign in with Google',
                                              style: ralewayStyle.copyWith(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account?"),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen()),
                                        );
                                      },
                                      child: Text('Sign up'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
