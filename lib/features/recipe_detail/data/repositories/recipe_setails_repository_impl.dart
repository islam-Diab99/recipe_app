import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/network/network_info.dart';
import 'package:recipe_app/features/recipe_detail/data/datasources/recipe_details_remote_data_source.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';
import 'package:recipe_app/features/recipe_detail/domain/repositories/recipe_detail_repository.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  final RecipeDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecipeDetailRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure,RecipeDetail>> getRecipeDetails(int recipeId) async {
    if (await networkInfo.isConnected) {
      try {
        final recipes = await remoteDataSource.getRecipeDetails(recipeId);
        return Right(recipes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } 
    else{
              return Left(OfflineFailure());

    }
  }
}