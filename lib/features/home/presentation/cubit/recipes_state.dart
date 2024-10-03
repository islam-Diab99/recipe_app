part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState();

  @override
  List<Object> get props => [];
}

class RecipesInitial extends RecipesState {}

class LoadingRecipesState extends RecipesState {}

class LoadedRecipesState extends RecipesState {
  final List<Recipe> recipes;

  const LoadedRecipesState({required this.recipes});

  @override
  List<Object> get props => [recipes];
}

class ErrorRecipesState extends RecipesState {
  final String message;

  const ErrorRecipesState({required this.message});

  @override
  List<Object> get props => [message];
}