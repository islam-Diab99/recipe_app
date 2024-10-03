import 'package:flutter/material.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.recipeDetail,
  });

  final RecipeDetail recipeDetail;

  @override
  Widget build(BuildContext context) {
    return Text(
      recipeDetail.title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 30),
    );
  }
}