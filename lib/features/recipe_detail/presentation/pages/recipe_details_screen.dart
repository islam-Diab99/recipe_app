import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/widgets/default_app_bar.dart';
import 'package:recipe_app/core/widgets/loading_widget.dart';
import 'package:recipe_app/features/home/presentation/widgets/message_display_widget.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_state.dart';
import 'package:recipe_app/features/recipe_detail/presentation/pages/recipe_details_widget.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar(),
        backgroundColor: Colors.white,
        body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
        builder: (context, state) {
          if (state is LoadingRecipeDetailsState) {
            return const LoadingWidget();
          } else if (state is LoadedRecipeDetailsState) {
            return RecipeDetailsWidget(recipeDetail: state.recipeDetail);
          } else if (state is ErrorRecipeDetailsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
