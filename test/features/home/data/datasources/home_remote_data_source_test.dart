import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/features/home/data/models/recipe_model.dart';
import 'package:recipe_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:recipe_app/core/network/api_constants.dart';

import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockDio mockDio; 

  setUp(() {
    mockDio = MockDio(); 
    dataSource = HomeRemoteDataSourceImpl(dio: mockDio);
  });

  group('getAllRecipes', () {
    final tRecipeList = [
      const RecipeModel(id: 1, title: 'Recipe 1', image: 'image1'),
      const RecipeModel(id: 2, title: 'Recipe 2', image: 'image2'),
    ];

    test('should return a list of RecipeModel when the response is successful', () async {
      // Arrange
      when(mockDio.get(
        ApiConstants.getAllRecipes,
        queryParameters: anyNamed('queryParameters'), 
      )).thenAnswer((_) async => Response(
            data: {'recipes': tRecipeList.map((r) => r.toJson()).toList()},
            statusCode: 200,
            requestOptions: RequestOptions(path: ApiConstants.getAllRecipes),
          ));

      // Act
      final result = await dataSource.getAllRecipes();

      // Assert
      expect(result, tRecipeList);
    });

    test('should throw ServerException when the response is unsuccessful', () async {
      // Arrange
      when(mockDio.get(
        ApiConstants.getAllRecipes,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {},
            statusCode: 404,
            requestOptions: RequestOptions(path: ApiConstants.getAllRecipes),
          ));

      // Act
      final call = dataSource.getAllRecipes;

      // Assert
      expect(call(), throwsA(isA<ServerException>()));
    });
  });

  group('searchByNameOrIngradient', () {
    final tRecipeList = [
      const RecipeModel(id: 1, title: 'Recipe 1', image: 'image_url_1'),
      const RecipeModel(id: 2, title: 'Recipe 2', image: 'image_url_2'),
    ];

    test('should return a list of RecipeModel when the response is successful', () async {
      // Arrange
      when(mockDio.get(
        ApiConstants.searchByNameOrIngradient,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {'results': tRecipeList.map((r) => r.toJson()).toList()},
            statusCode: 200,
            requestOptions: RequestOptions(path: ApiConstants.searchByNameOrIngradient),
          ));

      // Act
      final result = await dataSource.searchByNameOrIngradient('Recipe', true);

      // Assert
      expect(result, tRecipeList);
    });

    test('should throw ServerException when the response is unsuccessful', () async {
      // Arrange
      when(mockDio.get(
        ApiConstants.searchByNameOrIngradient,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {},
            statusCode: 404,
            requestOptions: RequestOptions(path: ApiConstants.searchByNameOrIngradient),
          ));

      // Act
      call() => dataSource.searchByNameOrIngradient('Recipe', true);

      // Assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });
}
