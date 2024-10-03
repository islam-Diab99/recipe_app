import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/widgets/loading_widget.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_bloc.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_event.dart';
import 'package:recipe_app/features/home/presentation/widgets/message_display_widget.dart';
import 'package:recipe_app/features/home/presentation/widgets/recipe_list_widget.dart';

class RecipesListBlocBuilder extends StatelessWidget {
  const RecipesListBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<RecipesBloc, RecipesState>(
        builder: (context, state) {
          if (state is LoadingRecipesState) {
            return const LoadingWidget();
          } else if (state is LoadedRecipesState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: RecipeListWidget(recipes: state.recipes));
          } else if (state is ErrorRecipesState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
     Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<RecipesBloc>(context).add(RefreshRecipesEvent());
}
}