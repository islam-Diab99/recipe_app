import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure,List<Recipe>>> getAllRecipes();
    searchByNameOrIngradient(String query,bool isSearchByName);
}