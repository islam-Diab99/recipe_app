import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/strings/failures.dart';
import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';
import 'package:recipe_app/features/home/domain/usecases/get_all_recipes.dart';
import 'package:recipe_app/features/home/domain/usecases/search_by_name_or_ingradient.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_bloc.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_event.dart';

import 'package:mockito/annotations.dart';

import 'recipes_bloc_test.mocks.dart';

@GenerateMocks([GetAllRecipesUsecase, SearchByNameOrIngradientUseCase])
void main() {
  late RecipesBloc bloc;
  late MockGetAllRecipesUsecase mockGetAllRecipesUsecase;
  late MockSearchByNameOrIngradientUseCase mockSearchByNameOrIngradientUseCase;

  setUp(() {
    mockGetAllRecipesUsecase = MockGetAllRecipesUsecase();
    mockSearchByNameOrIngradientUseCase = MockSearchByNameOrIngradientUseCase();
    bloc = RecipesBloc(
      getAllRecipes: mockGetAllRecipesUsecase,
      searchByNameOrIngradient: mockSearchByNameOrIngradientUseCase,
    );
  });

  const recipe1 = Recipe(id: 1, title: 'title1', image: 'image1',);
  const recipe2 = Recipe( id: 2, title: 'title2', image: 'image2', );

  test('initial state should be RecipesInitial', () {
    expect(bloc.state, equals(RecipesInitial()));
  });

  group('GetAllRecipes', () {
    test('should emit [LoadingRecipesState, LoadedRecipesState] when data is gotten successfully', () async {
     
      when(mockGetAllRecipesUsecase()).thenAnswer((_) async => const Right([recipe1, recipe2]));

  
      final expected = [
        LoadingRecipesState(),
        const LoadedRecipesState(recipes: [recipe1, recipe2]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(GetAllRecipesEvent());
    });

    test('should emit [LoadingRecipesState, ErrorRecipesState] when getting data fails', () async {
      // Arrange
      when(mockGetAllRecipesUsecase()).thenAnswer((_) async => Left(ServerFailure()));

      // Assert 
      final expected = [
        LoadingRecipesState(),
        const ErrorRecipesState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(GetAllRecipesEvent());
    });
  });

  group('SearchByNameOrIngradient', () {
    const query = 'chocolate';

    test('should emit [LoadingRecipesState, LoadedRecipesState] when search by name returns data', () async {
      // Arrange
      when(mockSearchByNameOrIngradientUseCase(isSearchByName: true, query: query))
          .thenAnswer((_) async => const Right([recipe1]));

      // Assert later
      final expected = [
        LoadingRecipesState(),
        const LoadedRecipesState(recipes: [recipe1]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const SearchByNameOrIngradientEvent(query: query, isSearchByName: true));
    });

    test('should emit [LoadingRecipesState, ErrorRecipesState] when search by ingredient fails', () async {
      // Arrange
      when(mockSearchByNameOrIngradientUseCase(isSearchByName: false, query: query))
          .thenAnswer((_) async => Left(OfflineFailure()));

      // Assert later
      final expected = [
        LoadingRecipesState(),
        const ErrorRecipesState(message: OFFLINE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const SearchByNameOrIngradientEvent(query: query, isSearchByName: false));
    });
  });

  group('RefreshRecipes', () {
    test('should emit [LoadingRecipesState, LoadedRecipesState] when data is refreshed successfully', () async {
      // Arrange
      when(mockGetAllRecipesUsecase()).thenAnswer((_) async => const Right([recipe1, recipe2]));

      // Assert later
      final expected = [
        LoadingRecipesState(),
        const LoadedRecipesState(recipes: [recipe1, recipe2]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(RefreshRecipesEvent());
    });
  });
}