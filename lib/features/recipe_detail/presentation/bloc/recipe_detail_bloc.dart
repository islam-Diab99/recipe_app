import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/strings/failures.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';
import 'package:recipe_app/features/recipe_detail/domain/usecases/get_recipe_detail.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_event.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_state.dart';



class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  final GetRecipeDetailsUsecase getRecipeDetails;
  RecipeDetailsBloc({
    required this.getRecipeDetails, 
  }) : super(RecipeDetailsInitial()) {
    on<RecipeDetailsEvent>((event, emit) async {
      if (event is GetRecipeDetailsEvent) {
        emit(LoadingRecipeDetailsState());

        final failureOrRecipeDetails = await getRecipeDetails(event.recipeId);
        emit(_mapFailureOrRecipeDetailsToState(failureOrRecipeDetails));
      } 
    
    });
  }

  RecipeDetailsState _mapFailureOrRecipeDetailsToState(Either<Failure, RecipeDetail> either) {
    return either.fold(
      (failure) => ErrorRecipeDetailsState(message: _mapFailureToMessage(failure)),
      (recipeDetails) => LoadedRecipeDetailsState(
       recipeDetail: recipeDetails,
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