import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/network/network_info.dart';
import 'package:recipe_app/features/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:recipe_app/features/favorite/domain/repositories/fav_repository.dart';
import 'package:recipe_app/features/recipe_detail/data/models/recipe_details_model.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FavoriteRepositoryImpl({required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure,List<RecipeDetail>>> getFavoriteRecipes() async {
 
      try {
        final recipes = await localDataSource.getFavoriteRecipes();
        return Right(recipes);
      } on EmptyCacheException {
        return Left(EmptyDataBaseFailure());
      }
   
  }
  
 @override
  Future<Either<Failure,Unit>> addToFavorite(RecipeDetail recipeDetail) async{
   
      try {
     RecipeDetailModel  recipeDetailModel= RecipeDetailModel(instructions: recipeDetail.instructions, id: recipeDetail.id, title: recipeDetail.title, image: recipeDetail.image, ingredients:List<IngredientModel>.from(recipeDetail.ingredients));
        localDataSource.addToFavorite(recipeDetailModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
   
    
  }
   @override
  Future<Either<Failure,Unit>> removeFavorite(int recipeId) async{
   
      try {
        localDataSource.removeFromFavorite(recipeId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
}

   @override
  Future<Either<Failure,bool>> isFavorite(int recipeId) async{
   
      try {
         final isFav= await localDataSource.isFavorite(recipeId);
        return  Right(isFav);
      } on ServerException {
        return Left(ServerFailure());
      }
}
}