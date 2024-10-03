
import 'package:dartz/dartz.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

import '../../../../core/error/failures.dart';

abstract class RecipeDetailRepository {
  Future<Either<Failure,RecipeDetail>> getRecipeDetails(int recipeId);
}