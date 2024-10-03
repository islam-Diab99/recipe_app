import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/features/favorite/domain/repositories/fav_repository.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class AddToFavoriteUsecase {
  late  FavoriteRepository repository;

  AddToFavoriteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(RecipeDetail recipeType) async {
    return await repository.addToFavorite(recipeType);
  }
}