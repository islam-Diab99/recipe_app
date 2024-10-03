import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/strings/failures.dart';
import 'package:recipe_app/features/favorite/domain/usecases/add_to_favorites.dart';
import 'package:recipe_app/features/favorite/domain/usecases/get_favorites.dart';
import 'package:recipe_app/features/favorite/domain/usecases/get_is_favorite_or_not.dart';
import 'package:recipe_app/features/favorite/domain/usecases/remove_favorite.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';
import 'package:mockito/annotations.dart';
import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([
  GetFavoritesUseCase,
  AddToFavoriteUsecase,
  RemoveFavoriteUseCase,
  IsFavoriteUseCase,
])
void main() {
  late FavoritesBloc bloc;
  late MockGetFavoritesUseCase mockGetFavoritesUseCase;
  late MockAddToFavoriteUsecase mockAddToFavoriteUsecase;
  late MockRemoveFavoriteUseCase mockRemoveFavoriteUseCase;
  late MockIsFavoriteUseCase mockIsFavoriteUseCase;

  setUp(() {
    mockGetFavoritesUseCase = MockGetFavoritesUseCase();
    mockAddToFavoriteUsecase = MockAddToFavoriteUsecase();
    mockRemoveFavoriteUseCase = MockRemoveFavoriteUseCase();
    mockIsFavoriteUseCase = MockIsFavoriteUseCase();

    bloc = FavoritesBloc(
      getFavorites: mockGetFavoritesUseCase,
      addToFavorite: mockAddToFavoriteUsecase,
      removeFavorite: mockRemoveFavoriteUseCase,
      isFavorite: mockIsFavoriteUseCase,
    );
  });

  const tRecipeDetail = RecipeDetail(
    id: 1,
    title: 'Recipe Title',
    image: 'image',
    ingredients: [Ingradint(name: 'Tomato')],
    instructions: 'Mix',
  );

  const tRecipeId = 1;

  group('GetFavoritesEvent', () {
    test('should emit [LoadingFavoritesState, LoadedFavoritesState] when data is fetched successfully', () async {
      // Arrange
      when(mockGetFavoritesUseCase.call())
          .thenAnswer((_) async => Right([tRecipeDetail]));

      // Assert later
      final expected = [
        LoadingFavoritesState(),
        const LoadedFavoritesState(favorites: [tRecipeDetail]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(GetFavoritesEvent());
    });

    test('should emit [LoadingFavoritesState, ErrorFavoritesState] when getting data fails', () async {
      // Arrange
      when(mockGetFavoritesUseCase.call())
          .thenAnswer((_) async => Left(ServerFailure()));

      // Assert later
      final expected = [
        LoadingFavoritesState(),
        const ErrorFavoritesState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(GetFavoritesEvent());
    });
  });

  group('AddToFavoriteEvent', () {
   

  

    test('should emit [LoadingRemoveFavoriteState, ErrorRemoveFavoriteState] when removing from favorites fails', () async {
      // Arrange
      when(mockRemoveFavoriteUseCase.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Assert later
      final expected = [
        LoadingRemoveFavoriteState(),
        const ErrorRemoveFavoriteState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(RemoveFavoriteEvent(recipeId: tRecipeId));
    });
  });

  group('GetIsFavoriteEvent', () {
    test('should emit [LoadingGetIsFavoriteState, LoadedGetIsFavoriteState] when checking if a recipe is a favorite is successful', () async {
      // Arrange
      when(mockIsFavoriteUseCase.call(any))
          .thenAnswer((_) async => Right(true));

      // Assert later
      final expected = [
        LoadingGetIsFavoriteState(),
        const LoadedGetIsFavoriteState(isFavorite: true),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const GetIsFavoriteEvent(recipeId: tRecipeId));
    });

    test('should emit [LoadingGetIsFavoriteState, ErrorGetIsFavoriteState] when checking if a recipe is a favorite fails', () async {
      // Arrange
      when(mockIsFavoriteUseCase.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Assert later
      final expected = [
        LoadingGetIsFavoriteState(),
        const ErrorGetIsFavoriteState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const GetIsFavoriteEvent(recipeId: tRecipeId));
    });
  });
}
