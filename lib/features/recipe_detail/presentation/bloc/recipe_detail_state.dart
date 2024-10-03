

import 'package:equatable/equatable.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

abstract class RecipeDetailsState extends Equatable {
  const RecipeDetailsState();

  @override
  List<Object> get props => [];
}

class RecipeDetailsInitial extends RecipeDetailsState {}

class LoadingRecipeDetailsState extends RecipeDetailsState {}

class LoadedRecipeDetailsState extends RecipeDetailsState {
  final RecipeDetail recipeDetail;

  const LoadedRecipeDetailsState({required this.recipeDetail});

  @override
  List<Object> get props => [recipeDetail];
}

class ErrorRecipeDetailsState extends RecipeDetailsState {
  final String message;

  const ErrorRecipeDetailsState({required this.message});

  @override
  List<Object> get props => [message];
}