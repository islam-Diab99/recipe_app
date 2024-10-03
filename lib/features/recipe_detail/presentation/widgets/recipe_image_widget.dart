import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class RecipeImage extends StatelessWidget {
  const RecipeImage({
    super.key,
    required this.recipeDetail,
  });

  final RecipeDetail recipeDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: CachedNetworkImageProvider(recipeDetail.image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}