import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:volunteer_vibes/app_color.dart';
import 'package:volunteer_vibes/app_style.dart';
import 'package:volunteer_vibes/services/auth_service.dart';
import 'package:volunteer_vibes/widget/responsive_widget.dart';
import 'package:volunteer_vibes/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState();

  bool showProgress = false;
  bool visible = false;
  // Initially password is obscure
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  String _password = '';

  // Toggles the password show status
  void _pass1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _pass2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void onRoleChanged(String? value) {
    setState(() {
      selectedRole = value!;
    });
  }

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  var selectedRole = "volunteer";

  void signUp(String email, String password, String role) async {
    // Display a loading indicator
    setState(() {
      showProgress = true;
    });

    if (_formkey.currentState!.validate()) {
      try {
        // Create user in Firebase Authentication
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Post user details to Firestore
        postDetailsToFirestore(email, role);
      } catch (e) {
        // Handle any registration errors
        print("Registration error: $e");
        // You can display an error message to the user if needed
      } finally {
        // Hide the loading indicator
        setState(() {
          showProgress = false;
        });
      }
    }
  }

  postDetailsToFirestore(String email, String role) async {
    try {
      var user = _auth.currentUser;

      if (user != null) {
        CollectionReference ref =
            FirebaseFirestore.instance.collection('users');

        // Use the provided text controllers to get user input values
        String name = nameController.text;
        String mobile = mobileController.text;

        // Save user details to Firestore
        await ref.doc(user.uid).set({
          'name': name,
          'email': email,
          'mobile': mobile,
          'role': role,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data saved successfully.'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the LoginScreen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Display a SnackBar if the user is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User is null. Registration failed.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Display a SnackBar for validation failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please correct the errors in the form.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: AppColors.backColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.0),
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
                                        text: ' Get Started',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Create an account to VolunteerVibes to get all features. ',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                SizedBox(height: height * 0.064),
                                //-------- NAME TEXT BOX ----------//
                                SizedBox(
                                  height: 50.0,
                                  width: width,
                                  child: TextFormField(
                                      controller: nameController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          // Display a SnackBar if the name is empty
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Name is required.'),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                        return null;
                                      },
                                      style: ralewayStyle.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteColor,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Iconsax.user,
                                        ),
                                        // contentPadding:
                                        //     const EdgeInsets.only(top: 16.0),
                                        labelText: 'Name',
                                        hintStyle: ralewayStyle.copyWith(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blueDarkColor
                                              .withOpacity(0.5),
                                        ),
                                      )),
                                ),
                                SizedBox(height: height * 0.014),
                                const SizedBox(height: 6.0),
                                //-------- EMAIL TEXT BOX ----------//
                                SizedBox(
                                  height: 50.0,
                                  width: width,
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        // Display a SnackBar if the email is empty
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Email is required.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      } else if (!RegExp(
                                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                          .hasMatch(val)) {
                                        // Display a SnackBar if the email format is incorrect
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Invalid email format.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                      return null;
                                    },
                                    style: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.whiteColor,
                                    ),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Iconsax.message,
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
                                //-------- PHONE NUMBER TEXT BOX ----------//
                                SizedBox(
                                  height: 50.0,
                                  width: width,
                                  child: TextFormField(
                                    controller: mobileController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        // Display a SnackBar if the mobile is empty
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Phone number is required.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      } else if (!RegExp(r'^01[0-9]{9}$')
                                          .hasMatch(val)) {
                                        // Display a SnackBar if the mobile format is incorrect
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Invalid phone number format.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                      return null;
                                    },
                                    style: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.whiteColor,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Iconsax.call),
                                      // contentPadding:
                                      // const EdgeInsets.only(top: 16.0),
                                      labelText: 'Phone Number',
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
                                    controller: passwordController,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.whiteColor,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      // minit ke 8
                                      suffixIcon: IconButton(
                                        onPressed: _pass2,
                                        icon: _obscureText2
                                            ? const Icon(Iconsax.eye_slash)
                                            : const Icon(Iconsax.eye),
                                      ),
                                      prefixIcon: const Icon(Iconsax.lock),
                                    ),
                                    validator: (val) {
                                      if (val!.length < 6) {
                                        // Display a SnackBar if the password is too short
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Password is too short. Please enter at least 6 characters.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                      return null;
                                    },
                                    onSaved: (val) => _password = val!,
                                    obscureText: _obscureText2,
                                  ),
                                ),

                                SizedBox(height: height * 0.014),

                                const SizedBox(height: 6.0),
                                //-------- CONFIRM PASSWORD TEXT BOX ----------//
                                SizedBox(
                                  height: 50.0,
                                  width: width,
                                  child: TextFormField(
                                    controller: confirmpassController,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.whiteColor,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      // minit ke 8
                                      suffixIcon: IconButton(
                                        onPressed: _pass1,
                                        icon: _obscureText1
                                            ? const Icon(Iconsax.eye_slash)
                                            : const Icon(Iconsax.eye),
                                      ),
                                      prefixIcon: const Icon(Iconsax.lock),
                                    ),
                                    validator: (val) {
                                      if (val != passwordController.text) {
                                        // Display a SnackBar if the passwords don't match
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Passwords do not match.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                      return null;
                                    },
                                    onSaved: (val) => _password = val!,
                                    obscureText: _obscureText1,
                                  ),
                                ),
                                SizedBox(height: height * 0.03),
                                //-------- USER ROLE DROPDOWN ----------//
                                SizedBox(
                                  height: 50.0,
                                  width: width,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedRole,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "volunteer",
                                        child: Text("Volunteer"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "admin",
                                        child: Text("Organization"),
                                      ),
                                      // Add more role options as needed
                                    ],
                                    onChanged: onRoleChanged,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Iconsax.user),
                                      labelText: 'Role',
                                      hintStyle: ralewayStyle.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blueDarkColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.05),
                                //-------- BUTTON SIGN UP ----------//
                                Center(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => signUp(
                                        emailController.text,
                                        passwordController.text,
                                        selectedRole,
                                      ),
                                      borderRadius: BorderRadius.circular(32.0),
                                      child: Ink(
                                        width: ResponsiveWidget.isSmallScreen(
                                                context)
                                            ? width / 1.5
                                            : width / 4,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: const Color.fromARGB(
                                              255, 17, 96, 200),
                                        ),
                                        child: Center(
                                          child: showProgress
                                              ? CircularProgressIndicator()
                                              : Text(
                                                  'Sign Up',
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

                                Center(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                      width: ResponsiveWidget.isSmallScreen(
                                              context)
                                          ? width / 1.5
                                          : width / 4,
                                      child: OutlinedButton(
                                        onPressed:
                                            AuthService().signInWithGoogle,
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
                                      const Text('Already have an account?'),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text('Sign in'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
