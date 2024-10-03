import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/network/network_info.dart';
import 'package:recipe_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Recipe>>> getAllRecipes() async {
    if (await networkInfo.isConnected) {
      try {
        final recipes = await remoteDataSource.getAllRecipes();
        return Right(recipes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } 
    else{
              return Left(OfflineFailure());

    }
  }
  
  @override
 Future<Either<Failure, List<Recipe>>>  searchByNameOrIngradient(String query, bool isSearchByName) async{
 if (await networkInfo.isConnected) {
      try {
        final recipes = await remoteDataSource.searchByNameOrIngradient(query,isSearchByName);
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