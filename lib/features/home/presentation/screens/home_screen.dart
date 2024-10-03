import 'package:flutter/material.dart';
import 'package:recipe_app/features/home/presentation/widgets/favorites_button.dart';
import 'package:recipe_app/features/home/presentation/widgets/recipes_list_bloc_builder.dart';
import 'package:recipe_app/features/home/presentation/widgets/search_widget.dart';


class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body:_buildBody() ,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title:const Text('Recipes App',style: TextStyle(fontWeight: FontWeight.bold)),
      actions: const [   
        FavoritesButton()
      ],
    );
  }
}

  Widget _buildBody() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: 
          Column(
            children: [
              SearchWidget(),
              RecipesListBlocBuilder(),
            ],
          ),
     
    );
  }










