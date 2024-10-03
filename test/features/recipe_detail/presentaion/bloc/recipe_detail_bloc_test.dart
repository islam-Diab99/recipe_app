
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_app/core/error/failures.dart';
import 'package:recipe_app/core/strings/failures.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';
import 'package:recipe_app/features/recipe_detail/domain/usecases/get_recipe_detail.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_event.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_state.dart';


import 'package:mockito/annotations.dart';

import 'recipe_detail_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeDetailsUsecase])
void main() {
  late RecipeDetailsBloc bloc;
  late MockGetRecipeDetailsUsecase mockGetRecipeDetailsUsecase;

  setUp(() {
    mockGetRecipeDetailsUsecase = MockGetRecipeDetailsUsecase();
    bloc = RecipeDetailsBloc(getRecipeDetails: mockGetRecipeDetailsUsecase);
  });

  const tRecipeId = 1;

  const List<Ingradint> tIngredients = [
    Ingradint(name: 'Tomato'),
    Ingradint(name: 'Cheese'),
  ];

  const tRecipeDetails = RecipeDetail(
    id: 1,
    title: 'title 1',
    image: 'image 1',
    ingredients: tIngredients,
    instructions: 'inst 1',
  );

  test('initial state should be RecipeDetailsInitial', () {
    expect(bloc.state, equals(RecipeDetailsInitial()));
  });

  group('GetRecipeDetails', () {
    test('should emit [LoadingRecipeDetailsState, LoadedRecipeDetailsState] when data is fetched successfully', () async {
      // Arrange
      when(mockGetRecipeDetailsUsecase(any))
          .thenAnswer((_) async => const Right(tRecipeDetails));

      // Assert later
      final expected = [
        LoadingRecipeDetailsState(),
        const LoadedRecipeDetailsState(recipeDetail: tRecipeDetails),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const GetRecipeDetailsEvent(recipeId: tRecipeId));
    });

    test('should emit [LoadingRecipeDetailsState, ErrorRecipeDetailsState] when getting data fails', () async {
      // Arrange
      when(mockGetRecipeDetailsUsecase(any)).thenAnswer((_) async => Left(ServerFailure()));

      // Assert later
      final expected = [
        LoadingRecipeDetailsState(),
        const ErrorRecipeDetailsState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const GetRecipeDetailsEvent(recipeId: tRecipeId));
    });
  });

  group('RefreshRecipeDetails', () {
    test('should emit [LoadingRecipeDetailsState, LoadedRecipeDetailsState] when data is refreshed successfully', () async {
      // Arrange
      when(mockGetRecipeDetailsUsecase(any))
          .thenAnswer((_) async => const Right(tRecipeDetails));

      // Assert later
      final expected = [
        LoadingRecipeDetailsState(),
        const LoadedRecipeDetailsState(recipeDetail: tRecipeDetails),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const GetRecipeDetailsEvent(recipeId: tRecipeId));
    });
  });
}
