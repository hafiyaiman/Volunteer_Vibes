import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController countryController;

  const AddressTextField({
    Key? key,
    required this.streetController,
    required this.cityController,
    required this.countryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 840,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: streetController,
            labelText: 'Street',
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: cityController,
            labelText: 'City',
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: countryController,
            labelText: 'Country',
          ),
        ],
      ),
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
