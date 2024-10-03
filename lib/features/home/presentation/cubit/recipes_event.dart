

import 'package:equatable/equatable.dart';

abstract class  RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class GetAllRecipesEvent extends RecipesEvent {



}
class SearchByNameOrIngradientEvent extends RecipesEvent {
final String query;
final bool isSearchByName;

  const SearchByNameOrIngradientEvent({required this.query, required this.isSearchByName}); 

  @override
  List<Object> get props => [];
}
class RefreshRecipesEvent extends RecipesEvent {



}