import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_bloc.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_event.dart';
import 'package:recipe_app/features/home/presentation/screens/home_screen.dart';
import 'package:recipe_app/core/services/service_locator.dart' as di;

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
     fontFamily: 'DMSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:BlocProvider(
           create: (_) => di.sl<RecipesBloc>()..add(GetAllRecipesEvent()),
        child:  const HomeScreen())
    );
  }
}
