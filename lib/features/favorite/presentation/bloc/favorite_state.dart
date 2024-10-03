
import 'package:equatable/equatable.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class LoadingFavoritesState extends FavoritesState {}

class LoadedFavoritesState extends FavoritesState {
  final List<RecipeDetail> favorites;

  const LoadedFavoritesState({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class ErrorFavoritesState extends FavoritesState {
  final String message;

  const ErrorFavoritesState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingAddFavoriteState extends FavoritesState {}

class LoadedAddFavoriteState extends FavoritesState {}

class ErrorAddFavoriteState extends FavoritesState {
  final String message;

  const ErrorAddFavoriteState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingRemoveFavoriteState extends FavoritesState {}

class LoadedRemoveFavoriteState extends FavoritesState {}

class ErrorRemoveFavoriteState extends FavoritesState {
  final String message;

  const ErrorRemoveFavoriteState({required this.message});

  @override
  List<Object> get props => [message];
}
class LoadingGetIsFavoriteState extends FavoritesState {}

class LoadedGetIsFavoriteState extends FavoritesState {
  final bool isFavorite;

  const LoadedGetIsFavoriteState({required this.isFavorite});
    @override
  List<Object> get props => [isFavorite];
}

class ErrorGetIsFavoriteState extends FavoritesState {
  final String message;

  const ErrorGetIsFavoriteState({required this.message});

  @override
  List<Object> get props => [message];
}