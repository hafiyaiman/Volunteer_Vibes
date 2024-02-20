import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/components/activities_table.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/components/address_text_area.dart';
import 'package:volunteer_vibes/screens/admin/dashboard/components/dropdown.dart';

import '../../app_color.dart';
import '../../constants.dart';
import 'dashboard/components/header.dart';

String getCurrentUserId() {
  // Access the current user from FirebaseAuth
  User? user = FirebaseAuth.instance.currentUser;

  // Check if the user is signed in
  if (user != null) {
    // Return the user ID
    return user.uid;
  } else {
    // If the user is not signed in, handle it accordingly
    print("User not signed in.");
    return ""; // or null, depending on your needs
  }
}

Future<String?> getNGOName() async {
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
      String? name = userSnapshot.data()?['name'];

      // Return the user's name
      return name;
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

class ActivitiesScreen extends StatefulWidget {
  ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String selectedCategory = "By Organizations";
  String userId = getCurrentUserId();
  Future<String?> name = getNGOName();

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? selectedStartDate : selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  Future<void> saveDataToFirebase(String userId) async {
    String? name = await getNGOName();
    print(selectedCategory);
    try {
      // Validate that all required fields are not empty
      if (titleController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          durationController.text.isEmpty ||
          daysController.text.isEmpty ||
          streetController.text.isEmpty ||
          cityController.text.isEmpty ||
          countryController.text.isEmpty) {
        // Handle validation error, you can show a snackbar or any feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all required fields.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      // Reference to the Firestore collection
      CollectionReference activitiesCollection =
          FirebaseFirestore.instance.collection('activities');

      // Determine the target collection based on the selected category
      String targetCollection = selectedCategory == 'Emergency Response'
          ? 'emergency_response'
          : 'by_organizations';

      // Save data to the determined collection
      await activitiesCollection
          .doc('PI8A2mCR56iMUYKvlBp5')
          .collection(targetCollection)
          .doc()
          .set({
        'organizationId': userId,
        'organizationName': name,
        'title': titleController.text,
        'description': descriptionController.text,
        'duration': durationController.text,
        'start_time': selectedStartTime.format(context),
        'end_time': selectedEndTime.format(context),
        'start_date': selectedStartDate,
        'end_date': selectedEndDate,
        'days': daysController.text,
        'street': streetController.text,
        'city': cityController.text,
        'country': countryController.text,
      });

      // Show a Snackbar with a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      // Optionally, add more error handling or success feedback
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: SafeArea(
            child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Header(),
                  SizedBox(height: defaultPadding * 2),
                  Container(
                    width: 3000,
                    decoration: BoxDecoration(
                      color: AppColors.darkBackColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Add New Activity"),
                          ),
                          SizedBox(height: defaultPadding),
                          Center(
                            child: Container(
                              height: 300,
                              width: 1200,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Your Event Name',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: descriptionController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Write a small description for the event',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClockTextField(
                                  labelText: 'Start Time',
                                  selectedTime: selectedStartTime,
                                  onTap: () => _selectTime(context, true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClockTextField(
                                  labelText: 'End Time',
                                  selectedTime: selectedEndTime,
                                  onTap: () => _selectTime(context, false),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: durationController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Duration',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DateTextField(
                                  labelText: 'Start Date',
                                  selectedDate: selectedStartDate,
                                  onTap: () => _selectDate(context, true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DateTextField(
                                  labelText: 'End Date',
                                  selectedDate: selectedEndDate,
                                  onTap: () => _selectDate(context, false),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: daysController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Number Of Days',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //TODO make dropdown selection
                          SizedBox(
                            width: 840,
                            child: CategoryDropdown(
                              onCategorySelected: (selectedCategory) {
                                print('Selected Category: $selectedCategory');
                                setState(() {
                                  this.selectedCategory = selectedCategory;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AddressTextField(
                              streetController: streetController,
                              cityController: cityController,
                              countryController: countryController,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  print('Button Pressed'); // Add this line
                                  await saveDataToFirebase(userId);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.primary,
                                ),
                                child: Text(
                                  'Save',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////////////
                  CombinedActivitiesTable(userId: userId)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class ClockTextField extends StatelessWidget {
  final String labelText;
  final TimeOfDay selectedTime;
  final Function onTap;

  const ClockTextField({
    required this.labelText,
    required this.selectedTime,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        readOnly: true,
        onTap: () => onTap(),
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          suffixIcon: Icon(Icons.access_time),
        ),
        controller: TextEditingController(text: selectedTime.format(context)),
      ),
    );
  }
}

class DateTextField extends StatelessWidget {
  final String labelText;
  final DateTime selectedDate;
  final Function onTap;

  const DateTextField({
    required this.labelText,
    required this.selectedDate,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        readOnly: true,
        onTap: () => onTap(),
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          suffixIcon: Icon(Icons.date_range),
        ),
        controller: TextEditingController(
            text: "${selectedDate.toLocal()}".split(' ')[0]),
      ),
    );
  }
}
