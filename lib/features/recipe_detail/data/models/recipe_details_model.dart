import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';


class IngredientModel extends Ingradint {
  const IngredientModel({required super.name});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['original']??'-',
    );
  }


}

class RecipeDetailModel extends RecipeDetail {
  const RecipeDetailModel({
    required super.instructions,
    required super.id,
    required super.title,
    required super.image,
  required List<IngredientModel> super.ingredients,  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    var ingredientsFromJson = (json['extendedIngredients'] as List)
        .map((ingredient) => IngredientModel.fromJson(ingredient))
        .toList();

    return RecipeDetailModel(
      id: json['id'],
      title: json['title']??'-',
      image: json['image']??'-',
      ingredients: ingredientsFromJson,
      instructions: json['instructions']??'-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'instructions': instructions,
      'extendedIngredients': ingredients.map((ingredient) => {'original': ingredient.name}).toList(), 
    };
  }
}