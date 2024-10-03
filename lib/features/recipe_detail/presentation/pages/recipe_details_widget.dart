import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';
import 'package:recipe_app/core/services/service_locator.dart' as di;
import 'package:recipe_app/features/recipe_detail/presentation/widgets/add_to_fav_button.dart';
import 'package:recipe_app/features/recipe_detail/presentation/widgets/ingradient_item_widget.dart';
import 'package:recipe_app/features/recipe_detail/presentation/widgets/recipe_image_widget.dart';
import 'package:recipe_app/features/recipe_detail/presentation/widgets/recipe_paser.dart';
import 'package:recipe_app/features/recipe_detail/presentation/widgets/title_text_widget.dart';

class RecipeDetailsWidget extends StatelessWidget {
  const RecipeDetailsWidget({super.key, required this.recipeDetail});
  final RecipeDetail recipeDetail;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => di.sl<FavoritesBloc>()
          ..add(GetIsFavoriteEvent(recipeId: recipeDetail.id)),
        child: Container(
          
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
             gradient: const LinearGradient(
      begin: Alignment.topCenter, 
      end: Alignment.bottomCenter,
      colors: [
        Colors.white, 
        Color.fromARGB(255, 174, 218, 255),
      ],
    ),
        
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddToFavoriteButton(recipeDetail: recipeDetail),
                TitleText(recipeDetail: recipeDetail),
                const SizedBox(height: 20,),
                RecipeImage(recipeDetail: recipeDetail),
                const Text(
                  'Ingradients',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10,),
                ...recipeDetail.ingredients.map((ingredient) {
                  return  IngradientItemWidget(ingredient: ingredient,);
                }),
                   const SizedBox(height: 15,),
                const Text(
                  'instructions',
                  style: TextStyle(fontSize: 30),
                ),
                   const SizedBox(height: 20,),
             ...parseInstructions(recipeDetail.instructions).map((e){
              return Align(
                   alignment: Alignment.topLeft,
                child: Text(e, style: const TextStyle(fontSize: 16)));
             }),
              
               const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}








