import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/features/home/data/models/recipe_model.dart';
import 'package:recipe_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:recipe_app/core/network/api_constants.dart';

import '../../home/data/datasources/home_remote_data_source_test.mocks.dart';


void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  final tRecipeList = [
    const RecipeModel(id: 1, title: 'Recipe 1', image: 'image1'),
    const RecipeModel(id: 2, title: 'Recipe 2', image: 'image2'),
  ];

  setUp(() {
    mockDio = MockDio();
    dataSource = HomeRemoteDataSourceImpl(dio: mockDio);
  });

  void mockDioGetSuccess(String url, dynamic data) {
    when(mockDio.get(
      url,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: data,
          statusCode: 200,
          requestOptions: RequestOptions(path: url),
        ));
  }

  void mockDioGetFailure(String url, int statusCode) {
    when(mockDio.get(
      url,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: {},
          statusCode: statusCode,
          requestOptions: RequestOptions(path: url),
        ));
  }

  group('getAllRecipes', () {
    test('should return a list of RecipeModel when the response is successful', () async {
      // Arrange
      mockDioGetSuccess(ApiConstants.getAllRecipes, {'recipes': tRecipeList.map((r) => r.toJson()).toList()});

      // Act
      final result = await dataSource.getAllRecipes();

      // Assert
      expect(result, tRecipeList);
    });

    test('should throw ServerException when the response is unsuccessful', () async {
      // Arrange
      mockDioGetFailure(ApiConstants.getAllRecipes, 404);

      // Act
      final call = dataSource.getAllRecipes;

      // Assert
      expect(call(), throwsA(isA<ServerException>()));
    });
  });

  group('searchByNameOrIngradient', () {
    test('should return a list of RecipeModel when the response is successful', () async {
      // Arrange
      mockDioGetSuccess(ApiConstants.searchByNameOrIngradient, {'results': tRecipeList.map((r) => r.toJson()).toList()});

      // Act
      final result = await dataSource.searchByNameOrIngradient('Recipe', true);

      // Assert
      expect(result, tRecipeList);
    });

    test('should throw ServerException when the response is unsuccessful', () async {
      // Arrange
      mockDioGetFailure(ApiConstants.searchByNameOrIngradient, 404);

      // Act
      call() => dataSource.searchByNameOrIngradient('Recipe', true);

      // Assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });
}
