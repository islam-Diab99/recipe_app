import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/features/favorite/domain/repositories/fav_repository.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class GetFavoritesUseCase {
  late  FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<RecipeDetail>>> call() async {
    return await repository.getFavoriteRecipes();
  }
}