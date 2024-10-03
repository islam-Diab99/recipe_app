import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:recipe_app/features/recipe_detail/data/models/recipe_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';

abstract class FavoriteLocalDataSource {
  Future<List<RecipeDetailModel>> getFavoriteRecipes();
  Future<Unit> addToFavorite(RecipeDetailModel recipeModel);
  Future<Unit> removeFromFavorite(int recipeId);
 Future<bool> isFavorite(int recipeId);
}

const String Fav_RECIPES = "Fav_Recipes2";

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl({required this.sharedPreferences});

 @override
Future<Unit> addToFavorite(RecipeDetailModel recipeModel) async {
  final List<String> existingFavorites =
      sharedPreferences.getStringList(Fav_RECIPES) ?? [];

  bool recipeExists = existingFavorites.any((favorite) {
    final Map<String, dynamic> jsonData = json.decode(favorite);
    return RecipeDetailModel.fromJson(jsonData).id == recipeModel.id;
  });

  if (!recipeExists) {
    existingFavorites.add(json.encode(recipeModel.toJson()));
    
    await sharedPreferences.setStringList(Fav_RECIPES, existingFavorites);
  }

  return Future.value(unit);
}

   @override
  Future<List<RecipeDetailModel>> getFavoriteRecipes() async {
 
    final List<String> jsonStringList = sharedPreferences.getStringList(Fav_RECIPES) ?? [];

    if (jsonStringList.isNotEmpty) {
      final List<RecipeDetailModel> recipes = jsonStringList.map((jsonString) {
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        return RecipeDetailModel.fromJson(jsonData);
      }).toList();

      return recipes;
    } else {
      throw EmptyCacheException();
    }
  }


  @override
  Future<Unit> removeFromFavorite(int recipeId) async {
    final List<String> existingFavorites = sharedPreferences.getStringList(Fav_RECIPES) ?? [];

    final updatedFavorites = existingFavorites.where((jsonString) {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return jsonData['id'] != recipeId;
    }).toList();

    await sharedPreferences.setStringList(Fav_RECIPES, updatedFavorites);

    return unit;
  }

   @override
  Future<bool> isFavorite(int recipeId) async {
    final List<String> existingFavorites =
        sharedPreferences.getStringList(Fav_RECIPES) ?? [];

    bool recipeExists = existingFavorites.any((favorite) {
      final Map<String, dynamic> jsonData = json.decode(favorite);
      return RecipeDetailModel.fromJson(jsonData).id ==  recipeId;
    });

    return Future.value(recipeExists);
  }
}