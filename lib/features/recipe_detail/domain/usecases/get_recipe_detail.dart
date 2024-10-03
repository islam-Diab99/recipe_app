import 'package:dartz/dartz.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';
import 'package:recipe_app/features/recipe_detail/domain/repositories/recipe_detail_repository.dart';

import '../../../../core/error/failures.dart';


class GetRecipeDetailsUsecase {
  late  RecipeDetailRepository repository;

  GetRecipeDetailsUsecase(this.repository);

  Future<Either<Failure, RecipeDetail>> call(int recipeId) async {
    return await repository.getRecipeDetails(recipeId);
  }
}