import 'package:flutter/material.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class IngradientItemWidget extends StatelessWidget {
  final Ingradint ingredient;
  const IngradientItemWidget({
    super.key, required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("• ",
                style: TextStyle(fontSize: 20)),
            Expanded(
              child: Text(ingredient.name,
                  style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}