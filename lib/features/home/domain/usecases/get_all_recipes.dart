import 'package:dartz/dartz.dart';
import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failures.dart';


class GetAllRecipesUsecase {
  late  HomeRepository repository;

  GetAllRecipesUsecase(this.repository);

  Future<Either<Failure, List<Recipe>>> call() async {
    return await repository.getAllRecipes();
  }
}