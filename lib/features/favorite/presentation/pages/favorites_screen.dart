import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/widgets/default_app_bar.dart';
import 'package:recipe_app/core/widgets/loading_widget.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:recipe_app/features/favorite/presentation/widgets/fav_list_widget.dart';
import 'package:recipe_app/features/home/presentation/widgets/message_display_widget.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultAppBar(),
      body:_buildBody() ,
    );
  }
}
  Widget _buildBody() {
    return Padding(
      
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<FavoritesBloc, FavoritesState>(        
        buildWhen: (prev,cur){
          return cur is LoadingFavoritesState ||cur is LoadedFavoritesState||cur is ErrorFavoritesState;
        },
        builder: (context, state) {
          if (state is LoadingFavoritesState) {
            return const LoadingWidget();
          } else if (state is LoadedFavoritesState) {
            return FavRecipeListWidget(recipes: state.favorites);
          } else if (state is ErrorFavoritesState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }


  




