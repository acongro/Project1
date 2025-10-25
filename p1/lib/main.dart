import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'recipe_list_screen.dart';
import 'recipe_detail_screen.dart';
import 'meal_planner_screen.dart';
import 'grocery_list_screen.dart';
import 'favorites_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  await appState.loadFromStorage();
  runApp(ChangeNotifierProvider(
    create: (_) => appState,
    child: const RecipePlannerApp(),
  ));
}

class RecipePlannerApp extends StatelessWidget {
  const RecipePlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.black,
      dividerColor: Colors.white24,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
        onPrimary: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.black,
        selectedColor: Colors.white12,
        side: const BorderSide(color: Colors.white24),
        labelStyle: const TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.black,
        hintStyle: TextStyle(color: Colors.white60),
        prefixIconColor: Colors.white70,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(color: Colors.black),
        behavior: SnackBarBehavior.floating,
      ),
    );

    return MaterialApp(
      title: 'Recipe Planner',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: theme,
      routes: {
        '/': (_) => const RecipeListScreen(),
        RecipeDetailScreen.route: (_) => const RecipeDetailScreen(),
        MealPlannerScreen.route: (_) => const MealPlannerScreen(),
        GroceryListScreen.route: (_) => const GroceryListScreen(),
        FavoritesScreen.route: (_) => const FavoritesScreen(),
      },
    );
  }
}
