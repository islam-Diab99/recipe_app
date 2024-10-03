import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/home/domain/entities/recipe_entity.dart';

import 'package:flutter/material.dart';

import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_event.dart';
import 'package:recipe_app/features/recipe_detail/presentation/pages/recipe_details_screen.dart';
import 'package:recipe_app/core/services/service_locator.dart' as di;


class RecipeListWidget extends StatelessWidget {
  final List<Recipe> recipes;
  const RecipeListWidget({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
  
    return ListView.builder(
      itemCount: recipes.isEmpty?1:recipes.length,
      itemBuilder: (context, index) {
        return recipes.isEmpty?const Center(child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Text('sorry, there is no results'),
        )): Card(
          color: const Color.fromARGB(255, 216, 237, 255),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: (){
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                     create: (_) => di.sl<RecipeDetailsBloc>()..add(GetRecipeDetailsEvent(recipeId: recipes[index].id)),
                    child: const RecipeDetailsScreen()),
                ),
              );
            },
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(recipes[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                
                    
                Expanded(
                  child: Text(
                    recipes[index].title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),maxLines: 3,overflow: TextOverflow.ellipsis,
                  ),
                ),
                ],
                
              ),
            ),
          ),
        );
  
      },
   
    );
  }
}