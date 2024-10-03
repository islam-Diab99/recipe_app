import 'package:equatable/equatable.dart';

class RecipeDetail extends Equatable {
  final int id;
  final String title;
  final String image;
    final List<Ingradint> ingredients;
 final String instructions;
  const RecipeDetail( {required this.instructions,required this.id, required this.title, required this.image, required this.ingredients});


  @override
  List<Object?> get props => [id, title, image,ingredients,instructions];
}


class Ingradint extends Equatable {

  final String name;

  const Ingradint({required this.name});



  @override
  List<Object?> get props => [name];
}