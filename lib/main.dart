import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/bloc_observer.dart';
import 'package:recipe_app/recipe_app.dart';
import 'package:recipe_app/core/services/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await di.init();
  runApp(const RecipeApp());
}
