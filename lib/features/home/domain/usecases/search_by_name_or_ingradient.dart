import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/home/domain/repositories/home_repository.dart';

class SearchByNameOrIngradientUseCase {
  late  HomeRepository repository;

  SearchByNameOrIngradientUseCase(this.repository);

  Future<Either<Failure, List<Recipe>>> call({required String query,required bool isSearchByName}) async {
    return await repository.searchByNameOrIngradient(query,isSearchByName);
  }
}