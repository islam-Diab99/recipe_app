import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/features/favorite/domain/repositories/fav_repository.dart';

class RemoveFavoriteUseCase {
  late  FavoriteRepository repository;

  RemoveFavoriteUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int recipeId) async {
    return await repository.removeFavorite(recipeId);
  }
}