import 'package:flutter/material.dart';

class SearchTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const SearchTypeSelector({super.key, 
    required this.selectedType,
    required this.onTypeChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Search by:'),
        const SizedBox(width: 10),
        Radio<String>(
          value: 'name',
          groupValue: selectedType,
          
          onChanged: (value) {
            onTypeChanged(value!);
          },
        ),
        const Text('Name'),
        Radio<String>(
          value: 'ingredient',
          groupValue: selectedType,
          onChanged: (value) {
            onTypeChanged(value!);
          },
        ),
        const Text('Ingredient'),
      ],
    );
  }
}
