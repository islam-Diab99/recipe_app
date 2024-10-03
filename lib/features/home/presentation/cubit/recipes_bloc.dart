import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/strings/failures.dart';
import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/home/domain/usecases/get_all_recipes.dart';
import 'package:recipe_app/features/home/domain/usecases/search_by_name_or_ingradient.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final GetAllRecipesUsecase getAllRecipes;
    final SearchByNameOrIngradientUseCase searchByNameOrIngradient;
  RecipesBloc({
    required this.getAllRecipes,
    required this.searchByNameOrIngradient
  }) : super(RecipesInitial()) {
    on<RecipesEvent>((event, emit) async {
      if (event is GetAllRecipesEvent) {
        emit(LoadingRecipesState());

        final failureOrRecipes = await getAllRecipes();
        emit(_mapFailureOrRecipesToState(failureOrRecipes));
      } 
      else if (event is RefreshRecipesEvent) {
        emit(LoadingRecipesState());

        final failureOrPosts = await getAllRecipes();
        emit(_mapFailureOrRecipesToState(failureOrPosts));
      }
       else if (event is SearchByNameOrIngradientEvent) {
        emit(LoadingRecipesState());

        final failureOrPosts = await searchByNameOrIngradient(isSearchByName:event.isSearchByName ,query: event.query);
        emit(_mapFailureOrRecipesToState(failureOrPosts));
      }
    });
  }

  RecipesState _mapFailureOrRecipesToState(Either<Failure, List<Recipe>> either) {
    return either.fold(
      (failure) => ErrorRecipesState(message: _mapFailureToMessage(failure)),
      (recipes) => LoadedRecipesState(
        recipes: recipes,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}