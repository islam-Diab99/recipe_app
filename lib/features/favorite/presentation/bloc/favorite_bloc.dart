import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/strings/failures.dart';
import 'package:recipe_app/features/favorite/domain/usecases/add_to_favorites.dart';
import 'package:recipe_app/features/favorite/domain/usecases/get_favorites.dart';
import 'package:recipe_app/features/favorite/domain/usecases/get_is_favorite_or_not.dart';
import 'package:recipe_app/features/favorite/domain/usecases/remove_favorite.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';



class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavorites;
    final AddToFavoriteUsecase addToFavorite;
        final RemoveFavoriteUseCase removeFavorite;
         final IsFavoriteUseCase isFavorite;
    
  FavoritesBloc({
    required this.getFavorites,
    required this.addToFavorite,
    required this.isFavorite,
    required this.removeFavorite
  }) : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetFavoritesEvent) {
        emit(LoadingFavoritesState());

        final failureOrFavorites = await getFavorites();
        emit(_mapFailureOrFavoritesToState(failureOrFavorites));
      } 
      else if (event is AddToFavoriteEvent) {
        emit(LoadingAddFavoriteState());

        final failureOrUnit = await addToFavorite(event.recipeDetail);
       failureOrUnit.fold(
        (failure) => ErrorAddFavoriteState(message: _mapFailureToMessage(failure)),
      (favorites) => LoadedAddFavoriteState(),
        );
      }
        else if (event is RemoveFavoriteEvent) {
        emit(LoadingRemoveFavoriteState());

        final failureOrUnit = await removeFavorite(event.recipeId);
       failureOrUnit.fold(
        (failure) =>emit(ErrorRemoveFavoriteState(message: _mapFailureToMessage(failure)),) ,
      (_) {
      add(GetFavoritesEvent());
      emit (LoadedRemoveFavoriteState(),);
      } 
        );
      }
       else if (event is GetIsFavoriteEvent) {
        emit(LoadingGetIsFavoriteState());

        final failureOrBool = await isFavorite(event.recipeId);
       failureOrBool.fold(
        (failure) =>emit(ErrorGetIsFavoriteState(message: _mapFailureToMessage(failure)),) ,
      (isFavorite) {
     
       emit (LoadedGetIsFavoriteState(isFavorite: isFavorite));
     
        } 
        );
      }
    });
  }

  FavoritesState _mapFailureOrFavoritesToState(Either<Failure, List<RecipeDetail>> either) {
    return either.fold(
      (failure) => ErrorFavoritesState(message: _mapFailureToMessage(failure)),
      (favorites) => LoadedFavoritesState(
        favorites: favorites,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
        case EmptyDataBaseFailure:
        return EMPTY_DATABASE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}