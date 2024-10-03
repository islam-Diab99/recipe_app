
import 'package:dartz/dartz.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

import '../../../../core/error/failures.dart';

abstract class FavoriteRepository {
  Future<Either<Failure,List<RecipeDetail>>> getFavoriteRecipes();
    Future<Either<Failure,Unit>> addToFavorite(RecipeDetail recipeDetail);
     Future<Either<Failure,bool>> isFavorite(int recipeId);
 Future<Either<Failure,Unit>> removeFavorite(int recipeId) ;
}