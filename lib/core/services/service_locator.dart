import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:recipe_app/core/network/dio_factory.dart';
import 'package:recipe_app/core/network/network_info.dart';
import 'package:recipe_app/features/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:recipe_app/features/favorite/data/repositories/fav_repositor_impl.dart';
import 'package:recipe_app/features/favorite/domain/repositories/fav_repository.dart';
import 'package:recipe_app/features/favorite/domain/usecases/add_to_favorites.dart';
import 'package:recipe_app/features/favorite/domain/usecases/get_favorites.dart';
import 'package:recipe_app/features/favorite/domain/usecases/get_is_favorite_or_not.dart';
import 'package:recipe_app/features/favorite/domain/usecases/remove_favorite.dart';
import 'package:recipe_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:recipe_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:recipe_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:recipe_app/features/home/domain/repositories/home_repository.dart';
import 'package:recipe_app/features/home/domain/usecases/get_all_recipes.dart';
import 'package:recipe_app/features/home/domain/usecases/search_by_name_or_ingradient.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_bloc.dart';
import 'package:recipe_app/features/recipe_detail/data/datasources/recipe_details_remote_data_source.dart';
import 'package:recipe_app/features/recipe_detail/data/repositories/recipe_setails_repository_impl.dart';
import 'package:recipe_app/features/recipe_detail/domain/repositories/recipe_detail_repository.dart';
import 'package:recipe_app/features/recipe_detail/domain/usecases/get_recipe_detail.dart';
import 'package:recipe_app/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  Dio dio = DioFactory.getDio();
// Bloc

  sl.registerFactory(() => RecipesBloc(getAllRecipes: sl(),searchByNameOrIngradient: sl()));
  sl.registerFactory(() => RecipeDetailsBloc(getRecipeDetails: sl()));
    sl.registerFactory(() => FavoritesBloc(getFavorites: sl(),addToFavorite: sl(),isFavorite: sl(),removeFavorite: sl()));


// Usecases

  sl.registerLazySingleton(() => GetAllRecipesUsecase(sl()));
    sl.registerLazySingleton(() => GetRecipeDetailsUsecase(sl()));
       sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
              sl.registerLazySingleton(() => AddToFavoriteUsecase(sl()));
              sl.registerLazySingleton(() => RemoveFavoriteUseCase(sl()));
                  sl.registerLazySingleton(() => IsFavoriteUseCase(sl()));
                          sl.registerLazySingleton(() => SearchByNameOrIngradientUseCase(sl()));



// Repository

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));
        sl.registerLazySingleton<RecipeDetailRepository>(() => RecipeDetailRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));

              sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl(
      localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dio: dio));
        sl.registerLazySingleton<RecipeDetailRemoteDataSource>(
      () => RecipeDetailRemoteDataSourceImpl(dio: dio));
            sl.registerLazySingleton<FavoriteLocalDataSource>(
      () => FavoriteLocalDataSourceImpl(sharedPreferences: sl()));


//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker()); 
   final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
}