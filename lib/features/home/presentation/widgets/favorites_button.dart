
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_event.dart';
import 'package:recipe_app/core/services/service_locator.dart' as di;
import 'package:recipe_app/features/favorite/presentation/pages/favorites_screen.dart';


class FavoritesButton extends StatelessWidget {
  const FavoritesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
    Navigator.push(context,MaterialPageRoute(
            builder: (context) => BlocProvider(
               create: (_) => di.sl<FavoritesBloc>()..add(GetFavoritesEvent()),
              child: const FavoritesScreen()),
          ));
    }, icon: const Icon(Icons.bookmark,color: Colors.blue,));
  }
}