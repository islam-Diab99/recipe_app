import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/features/favorite/domain/repositories/fav_repository.dart';

class IsFavoriteUseCase {
  late  FavoriteRepository repository;

  IsFavoriteUseCase(this.repository);

  Future<Either<Failure, bool>> call(int recipeId) async {
    return await repository.isFavorite(recipeId);
  }
}