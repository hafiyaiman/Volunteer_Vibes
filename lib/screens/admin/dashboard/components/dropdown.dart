import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final void Function(String) onCategorySelected;

  CategoryDropdown({required this.onCategorySelected});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String selectedCategory = 'By Organization'; // Default selection

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(
        labelText: 'Select Category',
      ),
      items: [
        DropdownMenuItem(
          value: 'By Organization',
          child: Text('By Organization'),
        ),
        DropdownMenuItem(
          value: 'Emergency Response',
          child: Text('Emergency Response'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
          widget.onCategorySelected(selectedCategory); // Call the callback
        });
      },
    );
  }
}
