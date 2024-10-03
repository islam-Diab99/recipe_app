

import 'package:equatable/equatable.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

abstract class  FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoritesEvent extends FavoritesEvent {



}

class AddToFavoriteEvent extends FavoritesEvent {
final RecipeDetail recipeDetail;

  const AddToFavoriteEvent({required this.recipeDetail});

  @override
  List<Object> get props => [recipeDetail];

}

class RemoveFavoriteEvent extends FavoritesEvent {
final int recipeId;

  const RemoveFavoriteEvent({required this.recipeId});


  @override
  List<Object> get props => [recipeId];

}
class GetIsFavoriteEvent extends FavoritesEvent {
final int recipeId;

  const GetIsFavoriteEvent({required this.recipeId});



  @override
  List<Object> get props => [recipeId];

}