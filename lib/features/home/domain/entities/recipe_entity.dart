import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String title;
  final String image;

  const Recipe({required this.id, required this.title, required this.image,});

  @override
  List<Object?> get props => [id, title, image];
}

