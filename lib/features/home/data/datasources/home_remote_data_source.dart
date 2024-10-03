
import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/api_constants.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/features/home/data/models/recipe_model.dart';

abstract class  HomeRemoteDataSource {
  Future<List<RecipeModel>> getAllRecipes();
    Future<List<RecipeModel>> searchByNameOrIngradient(String query,bool isSearchByName);

}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
   Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});
  @override

  
  @override
  Future<List<RecipeModel>> getAllRecipes() async{
  final response = await dio.get(
    
    ApiConstants.getAllRecipes,
    queryParameters: {
          'limitLicense': 'true',
          'number': 5,
          'apiKey':'92eaa2a0b3fb494788d7cf7ee6284ebc',
        },
        
    );
 if (response.statusCode == 200) {
      return List<RecipeModel>.from((response.data["recipes"] as List).map(
        (e) => RecipeModel.fromJson(e),
      ));
    } else {
      throw ServerException();
    }
  }
    @override
  Future<List<RecipeModel>> searchByNameOrIngradient(String query,bool isSearchByName) async{
  final response = await dio.get(
    
    ApiConstants.searchByNameOrIngradient,
    queryParameters: {
      
        isSearchByName?'query':  'includeIngredients': query,
          'apiKey':'92eaa2a0b3fb494788d7cf7ee6284ebc',
        },
        
    );
 if (response.statusCode == 200) {
      return List<RecipeModel>.from((response.data["results"] as List).map(
        (e) => RecipeModel.fromJson(e),
      ));
    } else {
      throw ServerException();
    }
  }
}