
import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/api_constants.dart';
import 'package:recipe_app/core/error/exceptions.dart';
import 'package:recipe_app/core/network/dio_factory.dart';
import 'package:recipe_app/features/recipe_detail/data/models/recipe_details_model.dart';

abstract class  RecipeDetailRemoteDataSource {
  Future<RecipeDetailModel> getRecipeDetails(int recipeId);
}

class RecipeDetailRemoteDataSourceImpl implements RecipeDetailRemoteDataSource {
   Dio dio=DioFactory.getDio();

  RecipeDetailRemoteDataSourceImpl({required this.dio});
  @override

  
  @override
  Future<RecipeDetailModel> getRecipeDetails(int recipeId) async{
  final response = await dio.get(
    
    ApiConstants.getRecipeDetails,
    queryParameters: {
'ids':recipeId,
          'apiKey':'92eaa2a0b3fb494788d7cf7ee6284ebc',
        },
        
    );
 if (response.statusCode == 200) {

      return RecipeDetailModel.fromJson((response.data as List).first) ;
    } else {
      throw ServerException();
    }
  }
}