

import 'package:equatable/equatable.dart';

abstract class  RecipeDetailsEvent extends Equatable {
  const RecipeDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetRecipeDetailsEvent extends RecipeDetailsEvent {
final int recipeId;

  const GetRecipeDetailsEvent({required this.recipeId});
  List<Object> get props => [recipeId];

}

