import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/widgets/loading_widget.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:recipe_app/core/services/service_locator.dart' as di;
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:recipe_app/features/recipe_detail/domain/entities/recipe_details.dart';

class AddToFavoriteButton extends StatelessWidget {
  const AddToFavoriteButton({
    super.key,
    required this.recipeDetail,
  });

  final RecipeDetail recipeDetail;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (prev, cur) => cur is LoadedGetIsFavoriteState,
      builder: (context, state) {
        if (state is LoadedGetIsFavoriteState) {
          return FavoriteButton(
            recipeDetail: recipeDetail,
            isFavorite: state.isFavorite,
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.recipeDetail,
    required this.isFavorite,
  });

  final RecipeDetail recipeDetail;
  final bool isFavorite;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      di
          .sl<FavoritesBloc>()
          .add(AddToFavoriteEvent(recipeDetail: widget.recipeDetail));
    } else {
      di
          .sl<FavoritesBloc>()
          .add(RemoveFavoriteEvent(recipeId: widget.recipeDetail.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: Icon(
        size: 30,
        _isFavorite ? Icons.bookmark_add : Icons.bookmark_add_outlined,
        color: _isFavorite ? Colors.blue : Colors.grey,
      ),
    );
  }
}
