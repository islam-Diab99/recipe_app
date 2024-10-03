import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final String searchType;
  final TextEditingController controller;

  const SearchInputField({super.key, 
    required this.searchType,
 required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: searchType == 'name'
            ? 'Enter recipe name'
            : 'enter one Gradient or multipegradient sepaarted with ,',
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0), 
          borderSide: const BorderSide(
            color: Colors.grey, 
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.grey, 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.blue, 
            width: 2.0, 
          ),    
      ),),
controller: controller,

    );
  }
}